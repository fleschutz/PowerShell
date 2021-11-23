<#
.SYNOPSIS
	Plays radio station N-JOY
.DESCRIPTION
	This script launches the Web browser and plays radio station N-JOY.
.EXAMPLE
	PS> ./play-radio-enjoy
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "http://streema.com/radios/play/N_Joy"
exit 0 # success
