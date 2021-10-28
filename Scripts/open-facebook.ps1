<#
.SYNOPSIS
	Opens Facebook's website
.DESCRIPTION
	This script launches the Web browser with Facebook's website.
.EXAMPLE
	PS> ./open-facebook
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.facebook.com"
exit 0 # success
