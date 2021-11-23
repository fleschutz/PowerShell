<#
.SYNOPSIS
	Opens Google Play
.DESCRIPTION
	This script launches the Web browser with the Google Play website.
.EXAMPLE
	PS> ./open-google-play
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://play.google.com/store"
exit 0 # success
