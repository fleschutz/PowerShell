<#
.SYNOPSIS
	Opens the Bitbucket website
.DESCRIPTION
	This script launches the Web browser with the Bitbucket website.
.EXAMPLE
	PS> ./open-bit-bucket-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://bitbucket.org"
exit 0 # success
