<#
.SYNOPSIS
	Shows Dublin city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Dublin city (Ireland).
.EXAMPLE
	PS> ./show-dublin-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Dublin"
exit 0 # success
