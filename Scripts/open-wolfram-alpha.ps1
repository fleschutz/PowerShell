<#
.SYNOPSIS
	Opens WolframAlpha
.DESCRIPTION
	This script launches the Web browser with the WolframAlpha website.
.EXAMPLE
	PS> ./open-wolfram-alpha
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.wolframalpha.com"
exit 0 # success
