<#
.SYNOPSIS
	Shows Lisbon city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Lisbon city (Portugal).
.EXAMPLE
	PS> ./show-lisbon-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Lisbon"
exit 0 # success
