<#
.SYNOPSIS
	Closes the Google Chrome Web browser
.DESCRIPTION
	close-chrome.ps1 
.EXAMPLE
	PS> ./close-chrome
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "Google Chrome" "chrome" "chrome"
exit 0 # success
