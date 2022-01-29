<#
.SYNOPSIS
	Opens Google Docs
.DESCRIPTION
	This PowerShell script launches the Web browser with the Google Docs website.
.EXAMPLE
	PS> ./open-google-docs
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://docs.google.com"
exit 0 # success
