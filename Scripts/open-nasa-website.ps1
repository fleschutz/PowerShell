<#
.SYNOPSIS
	Opens the NASA website
.DESCRIPTION
	This script launches the Web browser with the NASA website.
.EXAMPLE
	PS> ./open-nasa-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.nasa.gov"
exit 0 # success
