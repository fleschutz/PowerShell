<#
.SYNOPSIS
	Opens radio station YOU FM
.DESCRIPTION
	This script launches the Web browser with the radio station YOU FM.
.EXAMPLE
	PS> ./open-radio-you-f-m
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.radio.de/s/youfm"
exit 0 # success
