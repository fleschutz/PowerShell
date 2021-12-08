<#
.SYNOPSIS
	Shows the Tether rate 
.DESCRIPTION
	This script launches the Web browser and shows the Tether rate.
.EXAMPLE
	PS> ./show-tether-rate
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.bitstamp.net/markets/usdt/usd/"
exit 0 # success
