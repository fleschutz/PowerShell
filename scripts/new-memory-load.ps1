#Requires -Version 3.0

<#
.SYNOPSIS
    Maintains a target physical memory usage percentage for a specified duration.

.DESCRIPTION
    Allocates managed byte arrays in 64 MB blocks to bring the system's physical
    memory usage close to a specified target percentage, then holds it for the
    given duration.

    How it works:
        An initial pre-allocation phase rapidly fills memory to near the target
        by allocating 64 MB blocks and touching every 4 KB page to force physical
        backing.  The OS demand-pages memory: pages are not physically mapped until
        written, so the "Available Bytes" counter does not decrease until each page
        has been accessed.

        A feedback controller then runs once per second, calling the Win32
        GlobalMemoryStatusEx API and adding or releasing one 64 MB block as
        needed to track the target.

    Accuracy: ±1 block (64 MB) per adjustment cycle; typically ±1–3% on most
    server configurations.

.PARAMETER Percent
    Target memory usage percentage (1–99).
    Values above 95 leave very little memory for the OS kernel, drivers, and the
    PowerShell runtime itself.  Use 96–99 only in dedicated test environments where
    system instability or heavy paging is acceptable.

.PARAMETER Seconds
    Duration in seconds. Cannot be combined with -Minutes.

.PARAMETER Minutes
    Duration in minutes. Cannot be combined with -Seconds.

.INPUTS
    None

.OUTPUTS
    None

.EXAMPLE
    .\Start-MemoryLoad.ps1 -Percent 80 -Minutes 15
    Maintains 80% memory usage for 15 minutes.

.EXAMPLE
    .\Start-MemoryLoad.ps1 -Percent 70 -Seconds 30
    Maintains 70% memory usage for 30 seconds.

.EXAMPLE
    .\Start-MemoryLoad.ps1 -Percent 80 -Minutes 5 -Verbose
    Runs with verbose output showing start and finish messages.

.NOTES
    Memory usage is measured against TotalVisibleMemorySize (usable physical RAM),
    matching the denominator used by Windows Task Manager.

    Allocation is done in 64 MB blocks; control granularity is approximately
    ±64 MB per adjustment cycle.

    If there is insufficient free memory to reach the target (e.g. the system
    is already under heavy load), the script stops allocating and holds the
    highest achievable level without throwing an error.

    Targets above 95% leave very little headroom for the OS kernel, drivers,
    and the PowerShell runtime.  At these levels the system may page heavily,
    respond slowly, or trigger an OutOfMemoryException earlier than expected.
    The script handles OutOfMemoryException gracefully and holds the highest
    level it can reach, but overall system responsiveness is not guaranteed.

    Memory usage is measured via the Win32 GlobalMemoryStatusEx API, which
    issues a synchronous kernel call and returns 64-bit integer values.
    This avoids the float-precision loss and potential permission requirements
    of System.Diagnostics.PerformanceCounter, and always reflects the current
    physical memory state without PDH infrastructure lag.
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateRange(1, 99)]
    [int]$Percent,

    [Parameter(Mandatory, ParameterSetName = 'Seconds')]
    [ValidateRange(1, [int]::MaxValue)]
    [int]$Seconds,

    [Parameter(Mandatory, ParameterSetName = 'Minutes')]
    [ValidateRange(1, [int]::MaxValue)]
    [int]$Minutes
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
try { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 }
catch [System.IO.IOException] { <# No console handle attached (e.g. remote session, scheduled task) #> }

if ($Percent -gt 95) {
    Write-Warning (
        "${Percent}% leaves very little headroom for the OS and PowerShell runtime. " +
        'The system may page heavily or become unresponsive. ' +
        'Use only in a dedicated test environment.'
    )
}

# Compile C# helpers.
# MemLoad.MemoryHelper  – wraps the Win32 GlobalMemoryStatusEx API, which
#   issues a direct kernel call and returns 64-bit integer values.  This is
#   more reliable than System.Diagnostics.PerformanceCounter, which returns a
#   Single (32-bit float) via the PDH infrastructure and may require membership
#   of the Performance Monitor Users group on hardened Windows Server images.
#   If the PerformanceCounter returns 0 (its documented first-sample behaviour
#   even for raw counters on some builds), $usedBytes is set to $totalMemoryBytes
#   and Phase 1 breaks immediately without allocating anything — the primary
#   cause of the "no load visible in Task Manager" symptom.
# MemLoad.PageToucher   – writes to every 4 KB page to force physical backing.
#
# Guard: check every type defined in the block so that re-running the script in
# the same session is safe even if a previous version loaded only some of them.
$script:_memHelperLoaded   = $null -ne ('MemLoad.MemoryHelper'   -as [type])
$script:_pageToucherLoaded = $null -ne ('MemLoad.PageToucher'    -as [type])

if ($script:_memHelperLoaded -xor $script:_pageToucherLoaded) {
    throw (
        'Incompatible MemLoad types are already loaded in this PowerShell session ' +
        '(MemLoad.MemoryHelper={0}, MemLoad.PageToucher={1}). ' +
        'Start a new PowerShell session and run the script again.' -f
        $script:_memHelperLoaded, $script:_pageToucherLoaded
    )
}

if (-not $script:_memHelperLoaded) {
    Add-Type -TypeDefinition @'
        namespace MemLoad {
            using System.ComponentModel;
            using System.Runtime.InteropServices;

            [StructLayout(LayoutKind.Sequential)]
            public struct MEMORYSTATUSEX {
                public uint  dwLength;
                public uint  dwMemoryLoad;         // current usage 0-100 %
                public ulong ullTotalPhys;          // total physical RAM (bytes)
                public ulong ullAvailPhys;          // available physical RAM (bytes)
                public ulong ullTotalPageFile;
                public ulong ullAvailPageFile;
                public ulong ullTotalVirtual;
                public ulong ullAvailVirtual;
                public ulong ullAvailExtendedVirtual;
            }

            public static class MemoryHelper {
                [DllImport("kernel32.dll", SetLastError = true)]
                [return: MarshalAs(UnmanagedType.Bool)]
                private static extern bool GlobalMemoryStatusEx(ref MEMORYSTATUSEX lpBuffer);

                /// <summary>
                /// Returns a fresh MEMORYSTATUSEX snapshot directly from the
                /// Windows kernel.  Throws Win32Exception on failure.
                /// </summary>
                public static MEMORYSTATUSEX GetStatus() {
                    var ms = new MEMORYSTATUSEX();
                    ms.dwLength = (uint)Marshal.SizeOf(ms);
                    if (!GlobalMemoryStatusEx(ref ms))
                        throw new Win32Exception(Marshal.GetLastWin32Error());
                    return ms;
                }
            }

            public static class PageToucher {
                /// <summary>
                /// Writes 1 to the first byte of every 4 KB page to force
                /// physical page allocation in the OS.
                /// </summary>
                public static void Touch(byte[] buffer) {
                    for (int i = 0; i < buffer.Length; i += 4096)
                        buffer[i] = 1;
                }
            }
        }
'@
}

# Allocation unit: 64 MB.
# Larger than the Large Object Heap threshold (85 KB), which keeps these arrays
# out of Gen0/Gen1 collections and reduces GC overhead during the script's run.
$blockSizeBytes = 64MB   # [int] 67 108 864; safe for byte[] constructor

# Total usable physical memory via GlobalMemoryStatusEx.
# ullTotalPhys matches the "Total" denominator Windows Task Manager uses.
$initialStatus    = [MemLoad.MemoryHelper]::GetStatus()
$totalMemoryBytes = [long]$initialStatus.ullTotalPhys

$totalSeconds = if ($PSCmdlet.ParameterSetName -eq 'Minutes') { $Minutes * 60 } else { $Seconds }
$endTime      = [datetime]::UtcNow.AddSeconds($totalSeconds)
$durationStr  = if ($PSCmdlet.ParameterSetName -eq 'Minutes') { "${Minutes}m" } else { "${Seconds}s" }

# ArrayList holding references to every allocated block.
# As long as this list is reachable, the GC will not collect the arrays.
$allocatedBlocks = New-Object System.Collections.ArrayList

Write-Verbose ("Starting memory load: target {0}% for {1}  (Total: {2:N2} GB)" -f $Percent, $durationStr, ($totalMemoryBytes / 1GB))

$oomReached   = $false
$activityPre  = "Start-MemoryLoad: Pre-allocating to ${Percent}%"
$activityMain = "Start-MemoryLoad: Maintaining ${Percent}% memory usage"

try {
    # ── Phase 1: pre-allocate to approach the target quickly ─────────────────
    # Allocate one block per iteration (no sleep) until within one block of the
    # target. Write-Progress keeps the console from appearing unresponsive.
    while (-not $oomReached) {
        $availBytes  = [long]([MemLoad.MemoryHelper]::GetStatus().ullAvailPhys)
        $usedBytes   = $totalMemoryBytes - $availBytes
        $targetBytes = [long]($totalMemoryBytes * $Percent / 100.0)

        if (($targetBytes - $usedBytes) -le $blockSizeBytes) { break }

        $currentPct  = $usedBytes * 100.0 / $totalMemoryBytes
        $allocatedGB = [long]$allocatedBlocks.Count * $blockSizeBytes / 1GB

        Write-Progress -Activity $activityPre `
                       -Status ("Allocated: {0:N1} GB   Current: {1:N1}%   Target: {2}%" -f $allocatedGB, $currentPct, $Percent) `
                       -PercentComplete ([Math]::Min([int]($currentPct / $Percent * 100), 99))

        try {
            $block = New-Object byte[] $blockSizeBytes
            [MemLoad.PageToucher]::Touch($block)
            [void]$allocatedBlocks.Add($block)
        }
        catch [System.OutOfMemoryException] {
            $oomReached = $true
            Write-Warning ("Out of memory: stopped at {0:N1} GB ({1:N1}%). Target may not be reached." -f ([long]$allocatedBlocks.Count * $blockSizeBytes / 1GB), $currentPct)
        }
    }
    Write-Progress -Activity $activityPre -Completed

    # ── Phase 2: monitor and maintain until the duration elapses ─────────────
    while ([datetime]::UtcNow -lt $endTime) {
        Start-Sleep -Milliseconds 1000

        $remaining  = $endTime - [datetime]::UtcNow
        if ($remaining.TotalSeconds -lt 0) { break }
        $elapsedSec = [Math]::Max(0.0, $totalSeconds - $remaining.TotalSeconds)
        $pct        = [Math]::Min([int]($elapsedSec / $totalSeconds * 100), 100)

        $availBytes  = [long]([MemLoad.MemoryHelper]::GetStatus().ullAvailPhys)
        $usedBytes   = $totalMemoryBytes - $availBytes
        $targetBytes = [long]($totalMemoryBytes * $Percent / 100.0)
        $deltaBytes  = $targetBytes - $usedBytes
        $currentPct  = $usedBytes * 100.0 / $totalMemoryBytes

        if ($deltaBytes -gt $blockSizeBytes -and -not $oomReached) {
            # Below target: allocate one more block
            try {
                $block = New-Object byte[] $blockSizeBytes
                [MemLoad.PageToucher]::Touch($block)
                [void]$allocatedBlocks.Add($block)
            }
            catch [System.OutOfMemoryException] {
                $oomReached = $true
                Write-Warning 'Out of memory: cannot allocate more. Holding current level.'
            }
        }
        elseif ($deltaBytes -lt -$blockSizeBytes -and $allocatedBlocks.Count -gt 0) {
            # Above target: release one block and force the GC to reclaim it
            $allocatedBlocks.RemoveAt($allocatedBlocks.Count - 1)
            [System.GC]::Collect()
            [System.GC]::WaitForPendingFinalizers()
        }

        $allocatedMB = $allocatedBlocks.Count * 64   # each block is exactly 64 MB
        $elapsed     = [timespan]::FromSeconds($elapsedSec)
        $status      = 'Target: {0}%  Actual: {1:N1}%  Allocated: {2} MB  Elapsed: {3:hh\:mm\:ss}  Remaining: {4:hh\:mm\:ss}' -f `
                       $Percent, $currentPct, $allocatedMB, $elapsed, $remaining

        Write-Progress -Activity $activityMain -Status $status -PercentComplete $pct
    }
}
finally {
    # Release all blocks and force the GC to reclaim physical pages immediately.
    # Collect twice: first pass collects gen0/gen1 and queues finalizers;
    # WaitForPendingFinalizers flushes them; second pass collects what they freed.
    $allocatedBlocks.Clear()
    [System.GC]::Collect()
    [System.GC]::WaitForPendingFinalizers()
    [System.GC]::Collect()

    Write-Progress -Activity $activityPre  -Completed
    Write-Progress -Activity $activityMain -Completed
    Write-Verbose 'Memory load finished.'
}
