<#
.SYNOPSIS
	Shows Boston city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Boston city (USA).
.EXAMPLE
	PS> ./show-boston-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Boston"
exit 0 # success
