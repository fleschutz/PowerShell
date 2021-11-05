<#
.SYNOPSIS
	Shows Moscow in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows Moscow (Russia) in Google Maps.
.EXAMPLE
	PS> ./show-moscow
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.google.com/maps/place/Moscow"
exit 0 # success
