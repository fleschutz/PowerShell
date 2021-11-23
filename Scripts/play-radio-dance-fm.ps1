<#
.SYNOPSIS
	Plays radio station Dance FM
.DESCRIPTION
	This script launches the Web browser and plays radio station Dance FM.
.EXAMPLE
	PS> ./play-radio-dance-fm
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://tunein.com/radio/Dance-FM-s303095/"
exit 0 # success
