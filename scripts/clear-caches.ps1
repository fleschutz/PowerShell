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

	"⏳ 00% - Clearing user's trash folder..."
	Clear-RecycleBin -confirm:$false

	"⏳ 10% - Clearing user's temporary folder..."
	if (Test-Path "$env:TEMP/" -pathType container) { 
		Remove-Item -path "$env:TEMP\*" -recurse -force -errorAction SilentlyContinue
	} else {
		"  Folder is non-existing"
	}
	
	"⏳ 20% - Clearing user's crash dump folder..."
	if (Test-Path "~/AppData/Local/CrashDumps/" -pathType container) { 
		Remove-Item -Path "~/AppData/Local/CrashDumps/*" -Recurse -Force -ErrorAction SilentlyContinue
	} else {
		"  Folder is non-existing"
	}

	"⏳ 30% - Clearing Windows temporary folder..."
	Remove-Item -path "$env:SystemRoot\Temp\*" -recurse -force -errorAction SilentlyContinue

	"⏳ 40% - Clearing Windows prefetch folder..."
	Remove-Item -path "$env:SystemRoot\Prefetch\*" -force -errorAction SilentlyContinue

	"⏳ 50% - Clearing Windows update cache folder..."
	Remove-Item -path "$env:SystemRoot\SoftwareDistribution\Download\*" -recurse -force -errorAction SilentlyContinue

	"⏳ 60% - Clearing Windows DNS cache..."
	Clear-DnsClientCache

	"⏳ 70% - Clearing Windows File Explorer caches..."
	Remove-Item -path "$env:LOCALAPPDATA\IconCache.db" -force -errorAction SilentlyContinue
	Remove-Item -path "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\*.db" -force -errorAction SilentlyContinue

	"⏳ 80% - Clearing Internet Explorer cache folder..."
	Remove-Item -path "$env:LOCALAPPDATA\Microsoft\Windows\INetCache\*" -recurse -force -errorAction SilentlyContinue

	"⏳ 90% - Performing disk cleanup..."
	& cleanmgr /sagerun:1

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ All caches cleared in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (at line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
