<#
.SYNOPSIS
	Opens the Instagram website
.DESCRIPTION
	This script launches the Web browser with the Instagram website.
.EXAMPLE
	PS> ./open-instagram-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.instagram.com"
exit 0 # success
