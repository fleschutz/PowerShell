<#
.SYNOPSIS
	Opens the TikTok website
.DESCRIPTION
	This script launches the Web browser with the TikTok website.
.EXAMPLE
	PS> ./open-tiktop-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.tiktok.com"
exit 0 # success
