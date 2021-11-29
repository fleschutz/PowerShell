<#
.SYNOPSIS
	Shows the Google Chrome manual
.DESCRIPTION
	This script launches the Web browser with the Google Chrome manual.
.EXAMPLE
	PS> ./show-chrome-manual
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://support.google.com/chrome/?hl=en"
exit 0 # success
