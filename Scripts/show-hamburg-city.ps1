<#
.SYNOPSIS
	Shows Hamburg city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Hamburg city (Germany).
.EXAMPLE
	PS> ./show-hamburg-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Hamburg"
exit 0 # success
