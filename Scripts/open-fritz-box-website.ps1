<#
.SYNOPSIS
	Opens the FRITZ!Box website
.DESCRIPTION
	This script launches the Web browser with the FRITZ!Box website.
.EXAMPLE
	PS> ./open-fritz-box-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "http://fritz.box"
exit 0 # success
