<#
.SYNOPSIS
	Opens GitHub's website
.DESCRIPTION
	This script starts the Web browser with GitHub's website.
.EXAMPLE
	PS> ./open-github
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://github.com"
exit 0 # success
