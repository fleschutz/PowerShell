<#
.SYNOPSIS
	Shows Lissabon in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows Lissabon (Portugal) in Google Maps.
.EXAMPLE
	PS> ./show-lissabon
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.google.com/maps/place/Lissabon"
exit 0 # success
