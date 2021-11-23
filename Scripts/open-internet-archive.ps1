<#
.SYNOPSIS
	Opens the Internet Archive website 
.DESCRIPTION
	This script launches the Web browser with the Internet Archive website.
.EXAMPLE
	PS> ./open-internet-archive
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://archive.org"
exit 0 # success
