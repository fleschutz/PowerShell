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

& "$PSScriptRoot/open-browser.ps1" "https://tunein.com/radio/Radio-Gong-963-s17494/"
exit 0 # success
