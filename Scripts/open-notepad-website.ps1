<#
.SYNOPSIS
	Opens a Notepad website
.DESCRIPTION
	This script launches the Web browser with a Notepad website.
.EXAMPLE
	PS> ./open-notepad-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://notepad.js.org/"
exit 0 # success
