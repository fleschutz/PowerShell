<#
.SYNOPSIS
	Shows Tokyo city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Tokyo city (Japan).
.EXAMPLE
	PS> ./show-tokyo-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Tokyo"
exit 0 # success
