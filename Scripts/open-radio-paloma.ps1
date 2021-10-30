<#
.SYNOPSIS
	Opens radio station Paloma
.DESCRIPTION
	This script launches the Web browser with the radio station Paloma.
.EXAMPLE
	PS> ./open-radio-paloma
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.radio.de/s/radiopaloma"
exit 0 # success
