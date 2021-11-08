<#
.SYNOPSIS
	Shows Washington in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows Washington city (USA) in Google Maps.
.EXAMPLE
	PS> ./show-washington-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.google.com/maps/place/Washington"
exit 0 # success
