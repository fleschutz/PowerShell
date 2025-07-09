<#
.SYNOPSIS
	Opens Google Docs
.DESCRIPTION
	This PowerShell script launches the Web browser with the Google Docs website.
.EXAMPLE
	PS> ./open-google-docs.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

& "$PSScriptRoot/open-default-browser.ps1" "https://docs.google.com"
exit 0 # success
