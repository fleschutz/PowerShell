<#
.SYNOPSIS
	Shows Las Vegas city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Las Vegas city (USA).
.EXAMPLE
	PS> ./show-las-vegas-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Las+Vegas"
exit 0 # success
