<#
.SYNOPSIS
	Opens radio station JAM FM
.DESCRIPTION
	This script launches the Web browser with the radio station JAM FM.
.EXAMPLE
	PS> ./open-radio-jam-fm
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.jam.fm/"
exit 0 # success
