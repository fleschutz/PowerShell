<#
.SYNOPSIS
	close-chrome.ps1 
.DESCRIPTION
	Closes the Web browser Google Chrome gracefully
.EXAMPLE
	PS> ./close-chrome
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "Google Chrome" "chrome" "chrome"
exit 0 # success
