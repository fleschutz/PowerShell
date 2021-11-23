<#
.SYNOPSIS
	Plays radio station Galaxy
.DESCRIPTION
	This script launches the Web browser and plays radio station Galaxy.
.EXAMPLE
	PS> ./play-radio-galaxy
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "http://streema.com/radios/play/Radio_Galaxy_Rosenheim"
exit 0 # success
