<#
.SYNOPSIS
	Opens radio station ffn
.DESCRIPTION
	This script launches the Web browser with the radio station ffn.
.EXAMPLE
	PS> ./open-radio-f-f-n
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.radio.de/s/ffn"
exit 0 # success
