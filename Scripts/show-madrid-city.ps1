<#
.SYNOPSIS
	Shows Madrid in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows the city of Madrid (Spain) in Google Maps.
.EXAMPLE
	PS> ./show-madrid-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Madrid"
exit 0 # success
