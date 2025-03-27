<#
.SYNOPSIS
	Sets the working directory to the fonts folder
.DESCRIPTION
	This PowerShell script changes the working directory to the fonts folder.
.EXAMPLE
	PS> ./cd-fonts
	📂C:\Windows\Fonts
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$path = [Environment]::GetFolderPath('Fonts')
	if (-not(Test-Path "$path" -pathType container)) {
		throw "No fonts folder at 📂$path"
	}
	Set-Location "$path"
	"📂$path"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
