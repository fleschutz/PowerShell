<#
.SYNOPSIS
	Opens a fire place website
.DESCRIPTION
	This script launches the Web browser with a fire place website.
.EXAMPLE
	PS> ./open-fire-play
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://freefireplaces.com"
exit 0 # success
