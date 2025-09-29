<#
.SYNOPSIS
	Sets the working dir to the Windows directory
.DESCRIPTION
	This PowerShell script sets the current working directory to the Windows directory.
.EXAMPLE
	PS> ./cd-windows.ps1
	📂C:\Windows entered (has 7 files and 42 folders)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	if ($IsLinux -or $IsMacOS) { throw "This script requires Windows" }

	$path = Resolve-Path "$env:WINDIR"
	if (-not(Test-Path "$path" -pathType container)) { throw "No Windows directory at $path" }

	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path entered (has $($files.Count) files and $($folders.Count) folders)"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0])"
	exit 1
}
