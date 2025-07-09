<#
.SYNOPSIS
	Sets the working dir to the fonts folder
.DESCRIPTION
	This PowerShell script sets the current working directory to the fonts folder.
.EXAMPLE
	PS> ./cd-fonts.ps1
	📂C:\Windows\Fonts with 12 font files entered.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	$path = [Environment]::GetFolderPath('Fonts')
	if (-not(Test-Path "$path" -pathType container)) {
		throw "No fonts folder at: $path"
	}
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	"📂$path with $($files.Count) font files entered."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
