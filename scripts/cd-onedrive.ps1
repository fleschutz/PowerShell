<#
.SYNOPSIS
	Sets the working dir to the OneDrive folder
.DESCRIPTION
	This PowerShell script sets the current working directory to the user's OneDrive folder.
.EXAMPLE
	PS> ./cd-onedrive.ps1
	📂C:\Users\Markus\OneDrive with 2 files and 0 folders entered.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	if (-not(Test-Path "~/OneDrive" -pathType container)) {
		throw "No 'OneDrive' folder in your home directory - is OneDrive installed?"
	}
	$path = Resolve-Path "~/OneDrive"
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path with $($files.Count) files and $($folders.Count) folders entered."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0])"
	exit 1
}
