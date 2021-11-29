<#
.SYNOPSIS
	Shows Toronto city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Toronto city (Canada).
.EXAMPLE
	PS> ./show-toronto-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Toronto"
exit 0 # success
