<#
.SYNOPSIS
	Opens the Space Weather website 
.DESCRIPTION
	This script launches the Web browser with the Space Weather website.
.EXAMPLE
	PS> ./open-space-weather
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.spaceweather.com"
exit 0 # success
