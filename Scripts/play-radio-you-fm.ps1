<#
.SYNOPSIS
	Plays radio station YOU FM
.DESCRIPTION
	This script launches the Web browser and plays radio station YOU FM.
.EXAMPLE
	PS> ./play-radio-you-fm
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.radio.de/s/youfm"
exit 0 # success
