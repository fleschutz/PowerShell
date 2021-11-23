<#
.SYNOPSIS
	Plays the radio station Costa Del Mar
.DESCRIPTION
	This script launches the Web browser and plays radio station Costa Del Mar.
.EXAMPLE
	PS> ./play-radio-costa-del-mar
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.radio.de/s/costadelmar"
exit 0 # success
