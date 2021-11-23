<#
.SYNOPSIS
	Plays radio station CLUBMIX
.DESCRIPTION
	This script launches the Web browser and plays radio station CLUBMIX.
.EXAMPLE
	PS> ./play-radio-club-mix
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.radio.de/s/m1fmclubmix"
exit 0 # success
