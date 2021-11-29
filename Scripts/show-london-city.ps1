<#
.SYNOPSIS
	Shows London city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at London city (UK).
.EXAMPLE
	PS> ./show-london-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/London"
exit 0 # success
