<#
.SYNOPSIS
	Shows Las Vegas in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows Las Vegas city (USA) in Google Maps.
.EXAMPLE
	PS> ./show-las-vegas-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.google.com/maps/place/London"
exit 0 # success
