<#
.SYNOPSIS
	Change to the crash dumps folder
.DESCRIPTION
	This PowerShell script changes the working directory to the crash dumps directory (Windows only). Whenever a software crashes and crash dumps are enabled(!) a crash dump file is written. This file helps to identify the reason for the crash.
.EXAMPLE
	PS> ./cd-crashdumps
	📂C:\Users\Markus\AppData\Local\CrashDumps entered (has 3 files and 0 folders)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) { throw "Sorry, Windows only" }

	[string]$path = Resolve-Path -Path "~"
	if (!(Test-Path "$path" -pathType container)) { throw "No home directory at $path" }

	$path += "\AppData\Local\CrashDumps"
	if (!(Test-Path "$path" -pathType container)) { throw "No crashdumps folder at $path" }
	Set-Location "$Path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path entered (has $($files.Count) files and $($folders.Count) folders)"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
