<#
.SYNOPSIS
	Opens Google Find My Device 
.DESCRIPTION
	This script launches the Web browser with the Google Find My Device website.
.EXAMPLE
	PS> ./locate-my-phone
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/android/find"
exit 0 # success
