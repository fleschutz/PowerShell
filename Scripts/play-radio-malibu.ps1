<#
.SYNOPSIS
	Plays radio station Malibu
.DESCRIPTION
	This script launches the Web browser and plays radio station Malibu.
.EXAMPLE
	PS> ./play-radio-malibu
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.radio.de/s/malibufm"
exit 0 # success
