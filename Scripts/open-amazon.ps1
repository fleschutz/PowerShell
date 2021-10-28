<#
.SYNOPSIS
	Opens Amazon's website
.DESCRIPTION
	This script launches the Web browser with the Amazon website.
.EXAMPLE
	PS> ./open-amazon
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.amazon.com"
