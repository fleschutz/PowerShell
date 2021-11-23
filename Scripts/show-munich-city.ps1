<#
.SYNOPSIS
	Shows Munich in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows the city of Munich (Germany) in Google Maps.
.EXAMPLE
	PS> ./show-munich-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Munich"
exit 0 # success
