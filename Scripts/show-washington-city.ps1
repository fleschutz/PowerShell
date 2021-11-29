<#
.SYNOPSIS
	Shows Washington city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Washington city (USA).
.EXAMPLE
	PS> ./show-washington-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Washington"
exit 0 # success
