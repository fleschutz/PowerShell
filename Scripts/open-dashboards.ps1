<#
.SYNOPSIS
	Open dashboards
.DESCRIPTION
	This PowerShell script launches the Web browser with some dashboard websites.
.EXAMPLE
	PS> ./open-dashboards
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/open-default-browser.ps1" https://track.toggl.com/timer
& "$PSScriptRoot/open-default-browser.ps1" https://news.google.com
& "$PSScriptRoot/open-default-browser.ps1" https://www.windy.com/de/-Wetterradar-radar
& "$PSScriptRoot/open-default-browser.ps1" https://www.arcgis.com/apps/dashboards/c8af9c5411814584b460cc87cb7c3780
& "$PSScriptRoot/open-default-browser.ps1" https://radio.garden/visit/kempten/V5Ryr1S4
& "$PSScriptRoot/open-default-browser.ps1" https://www.foto-webcam.eu/
& "$PSScriptRoot/open-default-browser.ps1" https://sunnyportal.com/FixedPages/Dashboard.aspx
exit 0 # success
