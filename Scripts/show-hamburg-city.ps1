<#
.SYNOPSIS
	Shows Hamburg in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows the city of Hamburg (Germany) in Google Maps.
.EXAMPLE
	PS> ./show-hamburg-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.google.com/maps/place/Hamburg"
exit 0 # success
