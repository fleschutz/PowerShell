<#
.SYNOPSIS
	Opens radio station Arabella
.DESCRIPTION
	This script launches the Web browser with the radio station Arabella.
.EXAMPLE
	PS> ./open-radio-arabella
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.radio.de/s/radioarabella"
exit 0 # success
