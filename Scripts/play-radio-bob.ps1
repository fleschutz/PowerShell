<#
.SYNOPSIS
	Plays radio station BOB!
.DESCRIPTION
	This script launches the Web browser and plays radio station BOB!
.EXAMPLE
	PS> ./play-radio-bob
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "http://streema.com/radios/play/RADIO_BOB_BOBs_Alternative"
exit 0 # success
