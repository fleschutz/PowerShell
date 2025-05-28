<#
.SYNOPSIS
	Sets the working directory to the fonts folder
.DESCRIPTION
	This PowerShell script changes the working directory to the fonts folder.
.EXAMPLE
	PS> ./cd-fonts
	📂C:\Windows\Fonts (has 12 fonts and 0 folders)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$path = [Environment]::GetFolderPath('Fonts')
	if (-not(Test-Path "$path" -pathType container)) {
		throw "No fonts folder at: $path"
	}
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	$folders = Get-ChildItem $path -attributes Directory
	"📂$path entered (has $($files.Count) fonts and $($folders.Count) folders)"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
