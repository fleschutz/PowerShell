<#
.SYNOPSIS
	Show NYC in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at New York City.
.EXAMPLE
	PS> ./show-new-york-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.google.com/maps/place/New+York+City"
exit 0 # success
