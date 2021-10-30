<#
.SYNOPSIS
	Opens radio station SOFT POP
.DESCRIPTION
	This script launches the Web browser with the radio station SOFT POP.
.EXAMPLE
	PS> ./open-radio-soft-pop
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.radio.de/s/m1fmsofttop"
exit 0 # success
