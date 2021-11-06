<#
.SYNOPSIS
	Shows Toronto in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows the city of Toronto (Canada) in Google Maps.
.EXAMPLE
	PS> ./show-toronto-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.google.com/maps/place/Toronto"
exit 0 # success
