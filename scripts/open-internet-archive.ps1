<#
.SYNOPSIS
	Opens the Internet Archive website 
.DESCRIPTION
	This script launches the Web browser with the Internet Archive website.
.EXAMPLE
	PS> ./open-internet-archive.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

& "$PSScriptRoot/open-default-browser.ps1" "https://archive.org"
exit 0 # success
