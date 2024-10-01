<#
.SYNOPSIS
	Opens the Startpage website 
.DESCRIPTION
	This script launches the Web browser with the Startpage website.
.EXAMPLE
	PS> ./open-start-page
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.startpage.com"
exit 0 # success
