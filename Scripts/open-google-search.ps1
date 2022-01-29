<#
.SYNOPSIS
	Opens Google Search
.DESCRIPTION
	This PowerShell script launches the Web browser with the Google Search website.
.EXAMPLE
	PS> ./open-google-search
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://google.com"
exit 0 # success
