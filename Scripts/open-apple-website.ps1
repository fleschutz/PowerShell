<#
.SYNOPSIS
	Opens the Apple website
.DESCRIPTION
	This script launches the Web browser with the Apple website.
.EXAMPLE
	PS> ./open-apple-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.apple.com/"
exit 0 # success
