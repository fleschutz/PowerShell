<#
.SYNOPSIS
	Opens the Baidu website
.DESCRIPTION
	This script launches the Web browser with the Baidu website.
.EXAMPLE
	PS> ./open-baidu
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.baidu.com"
exit 0 # success
