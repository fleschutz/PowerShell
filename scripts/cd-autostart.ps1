<#
.SYNOPSIS
	Sets the working directory to the user's autostart folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's autostart folder.
.EXAMPLE
	PS> ./cd-autostart.ps1
	📂C:\Users\Markus\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup entered (has 0 files)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	if ($IsLinux -or $IsMacOS) { throw "This script requires Windows" }

	$path = Resolve-Path "~/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
	if (-not(Test-Path "$path" -pathType container)) { throw "The path to autostart folder '$path' doesn't exist (yet)" }
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	"📂$path entered (has $($files.Count) files)"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0])"
	exit 1
}
