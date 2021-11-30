<#
.SYNOPSIS
	Opens the Dropbox website
.DESCRIPTION
	This script launches the Web browser with the Dropbox website.
.EXAMPLE
	PS> ./open-dropbox-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.dropbox.com"
exit 0 # success
