<#
.SYNOPSIS
	Opens YouTube
.DESCRIPTION
	This script launches the Web browser with YouTube's website.
.EXAMPLE
	PS> ./open-youtube
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.youtube.com"
exit 0 # success
