<#
.SYNOPSIS
	Shows Vienna city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Vienna (Austria).
.EXAMPLE
	PS> ./show-vienna-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Vienna"
exit 0 # success
