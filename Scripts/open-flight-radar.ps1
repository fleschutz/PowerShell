<#
.SYNOPSIS
	Opens FlightRadar24
.DESCRIPTION
	This script launches the Web browser with the FlightRadar24 website.
.EXAMPLE
	PS> ./open-flight-radar
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.flightradar24.com"
exit 0 # success
