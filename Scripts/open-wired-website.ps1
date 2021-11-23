<#
.SYNOPSIS
	Opens the WIRED website
.DESCRIPTION
	This script launches the Web browser with the WIRED website.
.EXAMPLE
	PS> ./open-wired-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.wired.com/"
exit 0 # success
