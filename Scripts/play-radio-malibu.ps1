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

& "$PSScriptRoot/open-default-browser.ps1" "http://streema.com/radios/play/malibunightradio"
exit 0 # success
