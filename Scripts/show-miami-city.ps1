<#
.SYNOPSIS
	Shows Miami city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Miami city (USA).
.EXAMPLE
	PS> ./show-miami-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Miami"
exit 0 # success
