<#
.SYNOPSIS
	Shows Cairo in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows the city of Cairo (Egypt) in Google Maps.
.EXAMPLE
	PS> ./show-cairo-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Kairo"
exit 0 # success
