<#
.SYNOPSIS
	Shows the Bitcoin rate 
.DESCRIPTION
	This script launches the Web browser and shows the Bitcoin rate.
.EXAMPLE
	PS> ./show-bitcoin-rate
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.bitstamp.net/markets/btc/usd/"
exit 0 # success
