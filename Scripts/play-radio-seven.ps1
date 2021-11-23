<#
.SYNOPSIS
	Plays Radio 7 Ulm
.DESCRIPTION
	This script launches the Web browser and plays radio station 7 Ulm.
.EXAMPLE
	PS> ./play-radio-seven
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "http://streema.com/radios/play/Radio_7"
exit 0 # success
