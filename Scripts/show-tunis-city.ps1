<#
.SYNOPSIS
	Shows Tunis city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Tunis city  (Tunisia).
.EXAMPLE
	PS> ./show-tunis-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Tunis"
exit 0 # success
