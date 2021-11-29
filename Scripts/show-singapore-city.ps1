<#
.SYNOPSIS
	Shows Singapore city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Singapore city.
.EXAMPLE
	PS> ./show-singapore-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Singapore"
exit 0 # success
