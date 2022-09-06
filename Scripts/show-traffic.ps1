<#
.SYNOPSIS
	Shows the current traffic 
.DESCRIPTION
	This PowerShell script launches the Web browser with MSN showing the current traffic.
.EXAMPLE
	PS> ./show-traffic
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.msn.com/en-us/traffic?lvl=11&intent=roadClosures"
exit 0 # success
