<#
.SYNOPSIS
	Opens radio station Kiss Kiss
.DESCRIPTION
	This script launches the Web browser with the radio station Kiss Kiss.
.EXAMPLE
	PS> ./open-radio-kiss-kiss
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.radio.de/s/radiokisskiss"
exit 0 # success
