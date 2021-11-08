<#
.SYNOPSIS
	Shows Amsterdam in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows the city of Amsterdam (Netherlands) in Google Maps.
.EXAMPLE
	PS> ./show-amsterdam-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.google.com/maps/place/Amsterdam"
exit 0 # success
