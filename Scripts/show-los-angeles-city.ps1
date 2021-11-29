<#
.SYNOPSIS
	Shows Los Angeles city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Los Angeles city (USA).
.EXAMPLE
	PS> ./show-los-angeles-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Los+Angeles"
exit 0 # success
