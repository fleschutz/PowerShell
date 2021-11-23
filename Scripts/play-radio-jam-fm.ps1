<#
.SYNOPSIS
	Plays radio station JAM FM
.DESCRIPTION
	This script launches the Web browser and plays the radio station JAM FM.
.EXAMPLE
	PS> ./play-radio-jam-fm
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://tunein.com/radio/JAM-FM-New-Music-Radio-s136277/"
exit 0 # success
