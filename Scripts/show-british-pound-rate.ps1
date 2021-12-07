<#
.SYNOPSIS
	Shows the British Pound rate 
.DESCRIPTION
	This script launches the Web browser and shows the British Pound (GBP) rate.
.EXAMPLE
	PS> ./show-british-pound-rate
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.bitstamp.net/markets/gbp/usd/"
exit 0 # success
