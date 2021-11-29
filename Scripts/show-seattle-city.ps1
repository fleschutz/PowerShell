<#
.SYNOPSIS
	Shows Seattle city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Seattle city (USA).
.EXAMPLE
	PS> ./show-seattle-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Seattle"
exit 0 # success
