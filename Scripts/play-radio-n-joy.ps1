<#
.SYNOPSIS
	Plays radio station N-JOY
.DESCRIPTION
	This script launches the Web browser and plays radio station N-JOY.
.EXAMPLE
	PS> ./play-radio-n-joy
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.radio.de/s/n-joy"
exit 0 # success
