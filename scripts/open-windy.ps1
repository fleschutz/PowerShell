<#
.SYNOPSIS
	Opens the Windy website
.DESCRIPTION
	This script launches the Web browser with the Windy Weather Radar website.
.EXAMPLE
	PS> ./open-windy.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

& "$PSScriptRoot/open-URL.ps1" "https://www.windy.com/-Weather-radar-radar" "Windy Weather Radar: "
exit 0 # success
