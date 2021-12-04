<#
.SYNOPSIS
	Plays radio station Arabella
.DESCRIPTION
	This script launches the Web browser and plays radio station Arabella.
.EXAMPLE
	PS> ./play-radio-arabella
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "http://streema.com/radios/play/Radio_Arabella_2"
exit 0 # success
