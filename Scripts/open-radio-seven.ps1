<#
.SYNOPSIS
	Opens radio station 7
.DESCRIPTION
	This script launches the Web browser with the radio station 7.
.EXAMPLE
	PS> ./open-radio-seven
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.radio.de/s/radio7"
exit 0 # success
