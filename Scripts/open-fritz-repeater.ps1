<#
.SYNOPSIS
	Opens FRITZ!Repeater's Web interface
.DESCRIPTION
	This script launches the Web browser with the Web interface of FRITZ!Repeater.
.EXAMPLE
	PS> ./open-fritz-repeater
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "http://fritz.repeater"
exit 0 # success
