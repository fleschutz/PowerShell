<#
.SYNOPSIS
	Opens Google News
.DESCRIPTION
	This PowerShell script launches the Web browser with the Google News website.
.EXAMPLE
	PS> ./open-google-news
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://news.google.com"
exit 0 # success
