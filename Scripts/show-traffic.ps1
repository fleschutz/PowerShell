<#
.SYNOPSIS
	Shows the current traffic 
.DESCRIPTION
	This script launches the Web browser with MSN showing the current traffic.
.EXAMPLE
	PS> ./show-traffic
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.msn.com/en-us/traffic?lvl=11&intent=roadClosures"
exit 0 # success
