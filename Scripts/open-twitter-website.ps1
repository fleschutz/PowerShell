<#
.SYNOPSIS
	Opens the Twitter website
.DESCRIPTION
	This script launches the Web browser with the Twitter website.
.EXAMPLE
	PS> ./open-twitter-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.twitter.com"
exit 0 # success
