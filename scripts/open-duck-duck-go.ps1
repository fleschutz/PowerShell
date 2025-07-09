<#
.SYNOPSIS
	Opens the DuckDuckGo website 
.DESCRIPTION
	This PowerShell script launches the Web browser with the DuckDuckGo website.
.EXAMPLE
	PS> ./open-duck-duck-go
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

& "$PSScriptRoot/open-default-browser.ps1" "https://duckduckgo.com"
exit 0 # success
