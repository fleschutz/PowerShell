<#
.SYNOPSIS
	Shows Boston in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows the city of Boston (US) in Google Maps.
.EXAMPLE
	PS> ./show-boston-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Boston"
exit 0 # success
