<#
.SYNOPSIS
	Opens the YouTube website
.DESCRIPTION
	This script launches the Web browser with the YouTube website.
.EXAMPLE
	PS> ./open-youtube-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.youtube.com"
exit 0 # success
