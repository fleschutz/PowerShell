<#
.SYNOPSIS
	Opens radio station BOB!
.DESCRIPTION
	This script launches the Web browser with the radio station BOB!.
.EXAMPLE
	PS> ./open-radio-bob
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.radio.de/s/radiobob"
exit 0 # success
