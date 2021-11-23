<#
.SYNOPSIS
	Shows Dubai in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows the city of Dubai (VUE) in Google Maps.
.EXAMPLE
	PS> ./show-dubai-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Dubai"
exit 0 # success
