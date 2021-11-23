<#
.SYNOPSIS
	Opens the Amazon website
.DESCRIPTION
	This script launches the Web browser with the Amazon website.
.EXAMPLE
	PS> ./open-amazon-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.amazon.com"
exit 0 # success
