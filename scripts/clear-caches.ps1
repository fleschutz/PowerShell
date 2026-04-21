<#
.SYNOPSIS
	Clear caches
.DESCRIPTION
	This PowerShell script empties caches on the local computer to save space.
.EXAMPLE
	PS> ./clear-caches.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ (1/7) Clearing DNS client cache..."
	Clear-DnsClientCache

	"⏳ (2/7) Clearing Windows Prefetch folder..."
	Remove-Item -Path "$env:SystemRoot\Prefetch\*" -Force -ErrorAction SilentlyContinue

	"⏳ (3/7) Clearing Windows Temp folder..."
	Remove-Item -Path "$env:SystemRoot\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

	"⏳ (4/7) Clearing User Temp folder..."
	Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

	"⏳ (5/7) Clearing Internet Explorer Cache folder..."
	Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Windows\INetCache\*" -Recurse -Force -ErrorAction SilentlyContinue
	"⏳ (6/7) Performing Disk Cleanup..."
	& cleanmgr /sagerun:1

	"⏳ (7/7) Clearing Recycle Bin..."
	Clear-RecycleBin -Confirm:$false

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Caches cleared in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (at line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
