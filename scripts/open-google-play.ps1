<#
.SYNOPSIS
	Opens Google Play
.DESCRIPTION
	This PowerShell script launches the Web browser with the Google Play website.
.EXAMPLE
	PS> ./open-google-play.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

& "$PSScriptRoot/open-default-browser.ps1" "https://play.google.com/store"
exit 0 # success
