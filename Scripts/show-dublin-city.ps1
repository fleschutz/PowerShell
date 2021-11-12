<#
.SYNOPSIS
	Shows Dublin in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows Dublin city (Ireland) in Google Maps.
.EXAMPLE
	PS> ./show-dublin-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.google.com/maps/place/Dublin"
exit 0 # success
