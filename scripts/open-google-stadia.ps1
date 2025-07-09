<#
.SYNOPSIS
	Opens Google Stadia
.DESCRIPTION
	This PowerShell script launches the Web browser with the Google Stadia website.
.EXAMPLE
	PS> ./open-google-stadia.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

& "$PSScriptRoot/open-default-browser.ps1" "https://stadia.google.com"
exit 0 # success
