<#
.SYNOPSIS
	Opens radio station CLUBMIX
.DESCRIPTION
	This script launches the Web browser with the radio station CLUBMIX.
.EXAMPLE
	PS> ./open-radio-club-mix
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.radio.de/s/m1fmclubmix"
exit 0 # success
