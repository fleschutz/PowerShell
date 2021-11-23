<#
.SYNOPSIS
	Opens an egg timer
.DESCRIPTION
	This script launches the Web browser with the eggtimer website.
.EXAMPLE
	PS> ./open-egg-timer
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://e.ggtimer.com"
exit 0 # success
