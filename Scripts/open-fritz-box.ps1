<#
.SYNOPSIS
	Opens FRITZ!Box's Web interface
.DESCRIPTION
	This script starts the Web browser with FRITZ!Box's Web interface.
.EXAMPLE
	PS> ./open-fritz-box
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "http://fritz.box"
exit 0 # success
