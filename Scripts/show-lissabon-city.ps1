<#
.SYNOPSIS
	Shows Lissabon in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Lissabon city (Portugal).
.EXAMPLE
	PS> ./show-lissabon-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Lissabon"
exit 0 # success
