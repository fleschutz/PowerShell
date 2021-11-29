<#
.SYNOPSIS
	Opens the Outdoor Active website 
.DESCRIPTION
	This script launches the Web browser with the Outdoor Active website.
.EXAMPLE
	PS> ./open-outdoor-active-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.outdooractive.com"
exit 0 # success
