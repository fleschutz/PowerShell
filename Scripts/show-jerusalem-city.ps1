<#
.SYNOPSIS
	Shows Jerusalem city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Jerusalem city (Israel).
.EXAMPLE
	PS> ./show-jerusalem-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Jerusalem"
exit 0 # success
