<#
.SYNOPSIS
	Plays radio station FFN
.DESCRIPTION
	This script launches the Web browser and plays radio station FFN.
.EXAMPLE
	PS> ./play-radio-ffn
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.radio.de/s/ffn"
exit 0 # success
