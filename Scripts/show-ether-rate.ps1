<#
.SYNOPSIS
	Shows the Ether rate 
.DESCRIPTION
	This script launches the Web browser and shows the Ether rate.
.EXAMPLE
	PS> ./show-ether-rate
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.bitstamp.net/markets/eth/usd/"
exit 0 # success
