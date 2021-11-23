<#
.SYNOPSIS
	Plays Radio Blue 100.7
.DESCRIPTION
	This script launches the Web browser and plays radio station Blue 100.7.
.EXAMPLE
	PS> ./play-radio-blue
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "http://streema.com/radios/play/Blue_100.7"
exit 0 # success
