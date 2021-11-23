<#
.SYNOPSIS
	Opens the Baidu website
.DESCRIPTION
	This script launches the Web browser with the Baidu website.
.EXAMPLE
	PS> ./open-baidu-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.baidu.com"
exit 0 # success
