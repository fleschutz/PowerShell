<#
.SYNOPSIS
	Plays radio station Ibiza
.DESCRIPTION
	This script launches the Web browser and plays radio station Ibiza.
.EXAMPLE
	PS> ./play-radio-ibiza
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "http://streema.com/radios/play/Ibiza_Global_Radio"
exit 0 # success
