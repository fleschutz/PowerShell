<#
.SYNOPSIS
	Opens Google Search
.DESCRIPTION
	This script launches the Web browser with the Google Search website.
.EXAMPLE
	PS> ./open-google-search
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://google.com"
exit 0 # success
