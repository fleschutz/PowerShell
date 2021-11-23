<#
.SYNOPSIS
	Plays radio station Gong
.DESCRIPTION
	This script launches the Web browser and plays radio station Gong.
.EXAMPLE
	PS> ./play-radio-gong
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "http://streema.com/radios/play/Radio_Gong"
exit 0 # success
