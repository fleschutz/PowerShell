<#
.SYNOPSIS
	Opens the FRITZ!Repeater website
.DESCRIPTION
	This script launches the Web browser with the FRITZ!Repeater website.
.EXAMPLE
	PS> ./open-fritz-repeater-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "http://fritz.repeater"
exit 0 # success
