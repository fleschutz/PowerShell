<#
.SYNOPSIS
	Opens radio station JAM FM
.DESCRIPTION
	This script launches the Web browser with the radio station JAM FM.
.EXAMPLE
	PS> ./open-radio-jam-f-m
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.radio.de/s/jamfm"
exit 0 # success
