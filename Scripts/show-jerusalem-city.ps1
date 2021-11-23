<#
.SYNOPSIS
	Shows Jerusalem in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows Jerusalem city (Israel) in Google Maps.
.EXAMPLE
	PS> ./show-jerusalem-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Jerusalem"
exit 0 # success
