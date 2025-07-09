<#
.SYNOPSIS
	Opens a fire place website
.DESCRIPTION
	This PowerShell script launches the Web browser with a fire place website.
.EXAMPLE
	PS> ./open-fire-place
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

& "$PSScriptRoot/open-default-browser.ps1" "https://freefireplaces.com"
exit 0 # success
