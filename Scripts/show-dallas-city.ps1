<#
.SYNOPSIS
	Shows Dallas city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Dallas city (USA).
.EXAMPLE
	PS> ./show-dallas-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Dallas"
exit 0 # success
