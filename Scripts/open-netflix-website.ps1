<#
.SYNOPSIS
	Opens the Netflix website
.DESCRIPTION
	This script launches the Web browser with the Netflix website.
.EXAMPLE
	PS> ./open-netflix-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.netflix.com"
exit 0 # success
