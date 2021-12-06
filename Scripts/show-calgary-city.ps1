<#
.SYNOPSIS
	Shows Calgary city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Calgary city (Canada).
.EXAMPLE
	PS> ./show-calgary-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Calgary"
exit 0 # success
