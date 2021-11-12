<#
.SYNOPSIS
	Shows Atlanta in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows Atlanta city (USA) in Google Maps.
.EXAMPLE
	PS> ./show-atlanta-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.google.com/maps/place/Atlanta"
exit 0 # success
