<#
.SYNOPSIS
	Opens the radio station Costa Del Mar
.DESCRIPTION
	This script launches the Web browser with the radio station Costa Del Mar
.EXAMPLE
	PS> ./open-radio-costa-del-mar
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.radio.de/s/costadelmar"
exit 0 # success
