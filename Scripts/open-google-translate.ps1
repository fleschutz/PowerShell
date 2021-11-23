<#
.SYNOPSIS
	Opens Google Translate
.DESCRIPTION
	This script launches the Web browser with the Google Translate website.
.EXAMPLE
	PS> ./open-google-translate
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://translate.google.com"
exit 0 # success
