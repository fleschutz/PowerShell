<#
.SYNOPSIS
	Opens the GitHub website
.DESCRIPTION
	This script launches the Web browser with the GitHub website.
.EXAMPLE
	PS> ./open-github-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://github.com"
exit 0 # success
