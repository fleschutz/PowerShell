<#
.SYNOPSIS
	Plays radio station Absolute Chillout
.DESCRIPTION
	This script launches the Web browser and plays radio station Absolute Chillout.
.EXAMPLE
	PS> ./play-radio-absolute-chillout
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.radio.de/s/absolutechillout"
exit 0 # success
