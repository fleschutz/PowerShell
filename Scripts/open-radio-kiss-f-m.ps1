<#
.SYNOPSIS
	Opens radio station KISS FM
.DESCRIPTION
	This script launches the Web browser with the radio station KISS FM.
.EXAMPLE
	PS> ./open-radio-kiss-f-m
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.radio.de/s/kissfm"
exit 0 # success
