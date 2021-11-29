<#
.SYNOPSIS
	Shows Zurich city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Frankfurt city (Germany).
.EXAMPLE
	PS> ./show-zurich-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Zurich"
exit 0 # success
