<#
.SYNOPSIS
	Opens the Startpage website 
.DESCRIPTION
	This script launches the Web browser with the Startpage website.
.EXAMPLE
	PS> ./open-start-page.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

& "$PSScriptRoot/open-default-browser.ps1" "https://www.startpage.com"
exit 0 # success
