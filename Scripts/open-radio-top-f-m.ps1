<#
.SYNOPSIS
	Opens radio station TOP FM
.DESCRIPTION
	This script launches the Web browser with the radio station TOP FM.
.EXAMPLE
	PS> ./open-radio-top-f-m
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.radio.de/s/topfm"
exit 0 # success
