<#
.SYNOPSIS
	Shows San Francisco in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows the city of San Francisco (USA) in Google Maps.
.EXAMPLE
	PS> ./show-san-francisco-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.google.com/maps/place/San+Francisco"
exit 0 # success
