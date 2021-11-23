<#
.SYNOPSIS
	Opens the Facebook website
.DESCRIPTION
	This script launches the Web browser with the Facebook website.
.EXAMPLE
	PS> ./open-facebook-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.facebook.com"
exit 0 # success
