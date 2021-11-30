<#
.SYNOPSIS
	Opens the DistroWatch website
.DESCRIPTION
	This script launches the Web browser with the DistroWatch website.
.EXAMPLE
	PS> ./open-distro-watch-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://distrowatch.com/"
exit 0 # success
