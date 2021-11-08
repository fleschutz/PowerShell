<#
.SYNOPSIS
	Shows Tokyo in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows the city of Tokyo (Japan) in Google Maps.
.EXAMPLE
	PS> ./show-tokyo-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.google.com/maps/place/Tokyo"
exit 0 # success
