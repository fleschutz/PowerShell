<#
.SYNOPSIS
	Opens the Microsoft Bing website
.DESCRIPTION
	This script launches the Web browser with the Microsoft Bing website.
.EXAMPLE
	PS> ./open-microsoft-bing
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.bing.com"
exit 0 # success
