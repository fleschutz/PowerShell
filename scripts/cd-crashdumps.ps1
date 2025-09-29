<#
.SYNOPSIS
	Change to the crash dumps folder
.DESCRIPTION
	This PowerShell script changes the working directory to the crash dumps directory (Windows only). Whenever a software crashes and crash dumps are enabled(!) a crash dump file is written. This file helps to identify the reason for the crash.
.EXAMPLE
	PS> ./cd-crashdumps.ps1
	📂C:\Users\Markus\AppData\Local\CrashDumps entered (has 3 files)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	if ($IsLinux -or $IsMacOS) { throw "This script requires Windows" }

	[string]$path = Resolve-Path -Path "~"
	if (!(Test-Path "$path" -pathType container)) { throw "No home directory at '$path'" }

	$path += "\AppData\Local\CrashDumps"
	if (-not(Test-Path "$path" -pathType container)) { throw "The path to crashdumps folder '$path' doesn't exist (yet)" }

	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	"📂$path entered (has $($files.Count) files)"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0])"
	exit 1
}
