<#
.SYNOPSIS
	Change to the crash dumps folder
.DESCRIPTION
	This PowerShell script changes the working directory to the crash dumps directory (Windows only). Whenever a software crashes and crash dumps are enabled(!) a crash dump file is written. This file helps to identify the reason for the crash.
.EXAMPLE
	PS> ./cd-crashdumps.ps1
	📂C:\Users\Markus\AppData\Local\CrashDumps with 3 files entered.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	if ($IsLinux) { throw "Sorry, Windows only" }

	[string]$path = Resolve-Path -Path "~"
	if (!(Test-Path "$path" -pathType container)) { throw "No home directory at $path" }

	$path += "\AppData\Local\CrashDumps"
	if (!(Test-Path "$path" -pathType container)) { throw "No crashdumps folder at $path" }

	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	"📂$path with $($files.Count) files entered."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
