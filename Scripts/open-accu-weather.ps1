<#
.SYNOPSIS
	Opens the AccuWeather website 
.DESCRIPTION
	This script launches the Web browser with the AccuWeather website.
.EXAMPLE
	PS> ./open-accu-weather
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.accuweather.com"
exit 0 # success
