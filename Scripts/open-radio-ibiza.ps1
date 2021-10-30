<#
.SYNOPSIS
	Opens radio station Ibiza
.DESCRIPTION
	This script launches the Web browser with the radio station Ibiza.
.EXAMPLE
	PS> ./open-radio-ibiza
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.radio.de/s/ibiza973"
exit 0 # success
