<#
.SYNOPSIS
	Opens radio station Gong
.DESCRIPTION
	This script launches the Web browser with the radio station Gong.
.EXAMPLE
	PS> ./open-radio-gong
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.radio.de/s/radiogong"
exit 0 # success
