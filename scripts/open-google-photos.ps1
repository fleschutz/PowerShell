<#
.SYNOPSIS
	Opens Google Photos
.DESCRIPTION
	This PowerShell script launches the Web browser with the Google Photos website.
.EXAMPLE
	PS> ./open-google-photos.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

& "$PSScriptRoot/open-default-browser.ps1" "https://photos.google.com"
exit 0 # success
