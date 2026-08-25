<#
.SYNOPSIS
	Clear caches
.DESCRIPTION
	This PowerShell script empties all caches on the local computer to save disk space.
.EXAMPLE
	PS> ./clear-caches.ps1
	⏳ 10% - Clearing user's trash folder...
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ 10% - Clearing user's trash folder..."
	Clear-RecycleBin -Confirm:$false

	"⏳ 20% - Clearing user's temporary folder..."
	if (Test-Path "$env:TEMP/" -pathType container) { 
		Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
	} else {
		"  Folder is non-existing"
	}
	
	"⏳ 30% - Clearing user's crash dump folder..."
	if (Test-Path "~/AppData/Local/CrashDumps/" -pathType container) { 
		Remove-Item -Path "~/AppData/Local/CrashDumps/*" -Recurse -Force -ErrorAction SilentlyContinue
	} else {
		"  Folder is non-existing"
	}

	"⏳ 40% - Clearing Windows temporary folder..."
	Remove-Item -Path "$env:SystemRoot\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

	"⏳ 50% - Clearing Windows prefetch folder..."
	Remove-Item -Path "$env:SystemRoot\Prefetch\*" -Force -ErrorAction SilentlyContinue

	"⏳ 60% - Clearing Windows DNS cache..."
	Clear-DnsClientCache

	"⏳ 70% - Clearing Windows File Explorer caches..."
	Remove-Item -Path "$env:LOCALAPPDATA\IconCache.db" -Force -ErrorAction SilentlyContinue
	Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\*.db" -Force -ErrorAction SilentlyContinue

	"⏳ 80% - Clearing Internet Explorer cache folder..."
	Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Windows\INetCache\*" -Recurse -Force -ErrorAction SilentlyContinue

	"⏳ 90% - Performing disk cleanup..."
	& cleanmgr /sagerun:1

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ All caches cleared in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (at line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
