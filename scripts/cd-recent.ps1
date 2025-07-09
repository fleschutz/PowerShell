<#
.SYNOPSIS
	Sets the working directory to the 'recent' folder
.DESCRIPTION
	This PowerShell script changes the current working directory to the 'recent' folder.
.EXAMPLE
	PS> ./cd-recent.ps1
	📂C:\Users\Markus\AppData\Roaming\Microsoft\Windows\Recent with 2 files and 3 folders entered.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	$path = [Environment]::GetFolderPath('Recent')
	if (-not(Test-Path "$path" -pathType container)) { throw "No recent folder at $path" }

	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path with $($files.Count) files and $($folders.Count) folders entered."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0])"
	exit 1
}
