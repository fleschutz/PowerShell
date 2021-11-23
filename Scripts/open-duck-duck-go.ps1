<#
.SYNOPSIS
	Opens the DuckDuckGo website 
.DESCRIPTION
	This script launches the Web browser with the DuckDuckGo website.
.EXAMPLE
	PS> ./open-duck-duck-go
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://duckduckgo.com"
exit 0 # success
