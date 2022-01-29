<#
.SYNOPSIS
	Opens the AccuWeather website 
.DESCRIPTION
	This PowerShell script launches the Web browser with the AccuWeather website.
.EXAMPLE
	PS> ./open-accu-weather
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.accuweather.com"
exit 0 # success
