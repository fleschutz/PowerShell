<#
.SYNOPSIS
	Shows Kansas city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Kansas city (USA).
.EXAMPLE
	PS> ./show-kansas-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Kansas+City"
exit 0 # success
