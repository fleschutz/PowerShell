<#
.SYNOPSIS
	Shows Berlin city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Berlin city (Germany).
.EXAMPLE
	PS> ./show-berlin-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Berlin"
exit 0 # success
