<#
.SYNOPSIS
	Shows Los Angeles in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows Los Angeles city (USA) in Google Maps.
.EXAMPLE
	PS> ./show-los-angeles-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Los+Angeles"
exit 0 # success
