<#
.SYNOPSIS
	Plays radio station Kiss Kiss
.DESCRIPTION
	This script launches the Web browser and plays radio station Kiss Kiss.
.EXAMPLE
	PS> ./play-radio-kiss-kiss
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.radio.de/s/radiokisskiss"
exit 0 # success
