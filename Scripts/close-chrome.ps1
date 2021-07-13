<#
.SYNOPSIS
	close-chrome.ps1 
.DESCRIPTION
	Closes the Web browser Google Chrome gracefully
.EXAMPLE
	PS> .\close-chrome.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

& "$PSScriptRoot/close-program.ps1" "Google Chrome" "chrome" "chrome"
exit 0
