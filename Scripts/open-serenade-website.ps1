<#
.SYNOPSIS
	Opens the Serenade website
.DESCRIPTION
	This script launches the Web browser with the Serenade.ai website.
.EXAMPLE
	PS> ./open-serenade-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://serenade.ai/"
exit 0 # success
