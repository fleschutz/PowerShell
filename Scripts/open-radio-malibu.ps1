<#
.SYNOPSIS
	Opens radio station Malibu
.DESCRIPTION
	This script launches the Web browser with the radio station Malibu.
.EXAMPLE
	PS> ./open-radio-malibu
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.radio.de/s/malibufm"
exit 0 # success
