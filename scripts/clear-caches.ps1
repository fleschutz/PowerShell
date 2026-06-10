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

	"⏳ (1/8) Clearing Recycle Bin..."
	Clear-RecycleBin -Confirm:$false

	"⏳ (2/8) Clearing DNS client cache..."
	Clear-DnsClientCache

	"⏳ (3/8) Clearing Windows Prefetch folder..."
	Remove-Item -Path "$env:SystemRoot\Prefetch\*" -Force -ErrorAction SilentlyContinue

	"⏳ (4/8) Clearing Windows Temp folder..."
	Remove-Item -Path "$env:SystemRoot\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

	"⏳ (5/8) Clearing User Temp folder..."
	Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

	"⏳ (6/8) Clearing File Explorer icon cache database..."
	Remove-Item -Path "$env:LOCALAPPDATA\IconCache.db" -Force -ErrorAction SilentlyContinue
	Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\*.db" -Force -ErrorAction SilentlyContinue

	"⏳ (7/8) Clearing Internet Explorer Cache folder..."
	Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Windows\INetCache\*" -Recurse -Force -ErrorAction SilentlyContinue

	"⏳ (8/8) Performing Disk Cleanup..."
	& cleanmgr /sagerun:1

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Caches cleared in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (at line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
