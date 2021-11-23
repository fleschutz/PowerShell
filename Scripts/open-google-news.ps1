<#
.SYNOPSIS
	Opens Google News
.DESCRIPTION
	This script launches the Web browser with the Google News website.
.EXAMPLE
	PS> ./open-google-news
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://news.google.com"
exit 0 # success
