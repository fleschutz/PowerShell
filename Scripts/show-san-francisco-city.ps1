<#
.SYNOPSIS
	Shows San Francisco city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at San Francisco city (USA).
.EXAMPLE
	PS> ./show-san-francisco-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/San+Francisco"
exit 0 # success
