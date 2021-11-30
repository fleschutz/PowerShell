<#
.SYNOPSIS
	Opens the Plex website
.DESCRIPTION
	This script launches the Web browser with the Plex website.
.EXAMPLE
	PS> ./open-plex-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.plex.tv/"
exit 0 # success
