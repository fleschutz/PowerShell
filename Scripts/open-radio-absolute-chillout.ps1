<#
.SYNOPSIS
	Opens radio station Absolute Chillout
.DESCRIPTION
	This script launches the Web browser with the radio station Absolute Chillout.
.EXAMPLE
	PS> ./open-radio-absolute-chillout
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.radio.de/s/absolutechillout"
exit 0 # success
