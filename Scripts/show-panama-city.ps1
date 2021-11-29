<#
.SYNOPSIS
	Shows Panama city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Panama city (Panama).
.EXAMPLE
	PS> ./show-panama-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Panama+City"
exit 0 # success
