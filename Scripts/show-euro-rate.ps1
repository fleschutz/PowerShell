<#
.SYNOPSIS
	Shows the Euro rate 
.DESCRIPTION
	This script launches the Web browser and shows the Euro (EUR/€) rate.
.EXAMPLE
	PS> ./show-euro-rate
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.bitstamp.net/markets/eur/usd/"
exit 0 # success
