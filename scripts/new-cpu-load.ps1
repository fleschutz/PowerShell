#Requires -Version 3.0

<#
.SYNOPSIS
    Maintains a target CPU usage percentage for a specified duration.

.DESCRIPTION
    Controls the ratio of busy-loop to sleep time on each logical processor to
    bring the aggregate CPU usage (as shown in Task Manager) close to the target.

    How it works:
        The Windows multimedia timer API (timeBeginPeriod) is called to set the
        system timer resolution to 1 ms.  Windows defaults to ~15.6 ms resolution,
        which causes Thread.Sleep(20) to actually sleep ~31 ms (two timer ticks),
        producing a systematic ~10% undershoot at high targets (e.g. 80% → 70%).
        The 1 ms resolution eliminates this root cause.

        A proportional feedback controller running in the main thread samples the
        actual CPU usage once per second via PerformanceCounter and adjusts the
        worker busy/sleep ratio to track the target.  Workers pick up the updated
        ratio on the next 100 ms cycle without any thread interruption.

    Accuracy: ±3–5% variance is typical.

.PARAMETER Percent
    Target CPU usage percentage (1–100).

.PARAMETER Seconds
    Duration in seconds. Cannot be combined with -Minutes.

.PARAMETER Minutes
    Duration in minutes. Cannot be combined with -Seconds.

.PARAMETER Cores
    Number of logical processors to use. Defaults to all logical processors.

.INPUTS
    None

.OUTPUTS
    None

.EXAMPLE
    .\Start-CpuLoad.ps1 -Percent 80 -Minutes 15
    Maintains 80% CPU usage for 15 minutes.

.EXAMPLE
    .\Start-CpuLoad.ps1 -Percent 50 -Seconds 30
    Maintains 50% CPU usage for 30 seconds.

.EXAMPLE
    .\Start-CpuLoad.ps1 -Percent 100 -Minutes 5 -Cores 2
    Runs 100% load on 2 cores for 5 minutes.
    On a 4-core machine this equals roughly 50% aggregate CPU usage.

.NOTES
    CPU usage is measured with System.Diagnostics.PerformanceCounter.
    On some systems, membership of the Performance Monitor Users group is required.

    timeBeginPeriod(1) raises the system-wide timer resolution for the duration
    of the script, which may slightly increase power consumption on battery devices.
    timeEndPeriod(1) is always called in the finally block to restore the default.
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateRange(1, 100)]
    [int]$Percent,

    [Parameter(Mandatory, ParameterSetName = 'Seconds')]
    [ValidateRange(1, [int]::MaxValue)]
    [int]$Seconds,

    [Parameter(Mandatory, ParameterSetName = 'Minutes')]
    [ValidateRange(1, [int]::MaxValue)]
    [int]$Minutes,

    [ValidateRange(1, [int]::MaxValue)]
    [int]$Cores = [Environment]::ProcessorCount
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
try { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 }
catch [System.IO.IOException] { <# No console handle attached (e.g. remote session, scheduled task) #> }

$logicalCores = [Environment]::ProcessorCount
if ($Cores -gt $logicalCores) {
    throw "-Cores ($Cores) exceeds the logical processor count ($logicalCores)."
}

# Increase Windows timer resolution to 1 ms so Thread.Sleep is accurate.
# The default ~15.6 ms granularity causes Thread.Sleep(20) to sleep ~31 ms
# (two timer ticks), producing roughly 10% undershoot at high CPU targets.
# Example: targeting 80% yields spin=80ms, sleep=31ms → actual ≈ 72%.
if (-not ('Win32.TimerResolution' -as [type])) {
    Add-Type -MemberDefinition @'
        [DllImport("winmm.dll")]
        public static extern uint timeBeginPeriod(uint uPeriod);
        [DllImport("winmm.dll")]
        public static extern uint timeEndPeriod(uint uPeriod);
'@ -Name 'TimerResolution' -Namespace 'Win32'
}
$timerResolutionSet = [Win32.TimerResolution]::timeBeginPeriod(1) -eq 0

$totalSeconds = if ($PSCmdlet.ParameterSetName -eq 'Minutes') { $Minutes * 60 } else { $Seconds }
$endTime      = [datetime]::UtcNow.AddSeconds($totalSeconds)

# Shared mutable state for closed-loop control.
# Workers read BusyMs/SleepMs each cycle; the controller updates them at runtime.
$sharedState = [hashtable]::Synchronized(@{
    BusyMs  = $Percent
    SleepMs = 100 - $Percent
})

# Worker: spin for BusyMs ms, sleep for SleepMs ms within each ~100 ms window.
# Reads duty-cycle values from shared state so the proportional controller can
# adjust them without stopping or restarting threads.
$workerScript = {
    param([hashtable]$State, [datetime]$EndTime)
    while ([datetime]::UtcNow -lt $EndTime) {
        $busyMs  = $State.BusyMs
        $sleepMs = $State.SleepMs
        $sw = [System.Diagnostics.Stopwatch]::StartNew()
        while ($sw.ElapsedMilliseconds -lt $busyMs) { }
        if ($sleepMs -gt 0) {
            [System.Threading.Thread]::Sleep($sleepMs)
        }
    }
}

# CPU usage counter — discard the first sample, which is always 0
$cpuCounter = $null
try {
    $cpuCounter = New-Object -TypeName System.Diagnostics.PerformanceCounter `
                             -ArgumentList 'Processor', '% Processor Time', '_Total'
    $null = $cpuCounter.NextValue()
}
catch {
    Write-Warning "Failed to initialize PerformanceCounter. Closed-loop control will be disabled: $_"
}

# Create a runspace pool and launch one worker per core in parallel
$pool = [System.Management.Automation.Runspaces.RunspaceFactory]::CreateRunspacePool(1, $Cores)
$pool.Open()

$runspaces = @(for ($i = 0; $i -lt $Cores; $i++) {
    $ps = [PowerShell]::Create()
    $ps.RunspacePool = $pool
    $null = $ps.AddScript($workerScript).AddArgument($sharedState).AddArgument($endTime)
    [PSCustomObject]@{
        PowerShell = $ps
        Handle     = $ps.BeginInvoke()
    }
})

$durationStr = if ($PSCmdlet.ParameterSetName -eq 'Minutes') { "${Minutes}m" } else { "${Seconds}s" }
Write-Verbose ("Starting CPU load: {0}% across {1} core(s) for {2}" -f $Percent, $Cores, $durationStr)

# Proportional gain for the feedback controller.
# Each 1-second sample drives a correction of (error * kP) percentage points.
# A conservative gain avoids oscillation while still converging within ~5–10 s.
$kP            = 0.5
$effectiveBusy = [double]$Percent

try {
    while ([datetime]::UtcNow -lt $endTime) {
        Start-Sleep -Milliseconds 1000

        $remaining  = $endTime - [datetime]::UtcNow
        if ($remaining.TotalSeconds -lt 0) { break }
        $elapsedSec = [Math]::Max(0.0, $totalSeconds - $remaining.TotalSeconds)
        $pct        = [Math]::Min([int]($elapsedSec / $totalSeconds * 100), 100)

        $actualCpuStr = 'N/A'
        if ($null -ne $cpuCounter) {
            $actualCpu    = $cpuCounter.NextValue()
            $actualCpuStr = '{0:0.0}%' -f $actualCpu

            # Proportional controller: nudge effective duty cycle toward target.
            # Positive error (actual < target) increases effectiveBusy; negative decreases it.
            $error         = $Percent - $actualCpu
            $effectiveBusy = [Math]::Min([Math]::Max($effectiveBusy + $kP * $error, 1.0), 100.0)

            $sharedState.BusyMs  = [int][Math]::Round($effectiveBusy)
            $sharedState.SleepMs = [Math]::Max(0, 100 - $sharedState.BusyMs)
        }

        $elapsed = [timespan]::FromSeconds($elapsedSec)
        $status  = 'Target: {0}%  Actual: {1}  Duty: {2}/{3} ms  Elapsed: {4:hh\:mm\:ss}  Remaining: {5:hh\:mm\:ss}' -f `
                   $Percent, $actualCpuStr, $sharedState.BusyMs, $sharedState.SleepMs, $elapsed, $remaining

        Write-Progress -Activity "Start-CpuLoad: Maintaining ${Percent}% CPU load" `
                       -Status $status `
                       -PercentComplete $pct
    }
}
finally {
    foreach ($rs in $runspaces) {
        try { $rs.PowerShell.Stop() } catch { }
        $rs.PowerShell.Dispose()
    }
    $pool.Close()
    $pool.Dispose()
    if ($null -ne $cpuCounter) { $cpuCounter.Dispose() }
    if ($timerResolutionSet) { $null = [Win32.TimerResolution]::timeEndPeriod(1) }
    Write-Progress -Activity "Start-CpuLoad: Maintaining ${Percent}% CPU load" -Completed
    Write-Verbose 'CPU load finished.'
}
