<#
.SYNOPSIS
	Shows the US$ rate 
.DESCRIPTION
	This script launches the Web browser and shows the US Dollar (USD/US$) rate.
.EXAMPLE
	PS> ./show-us-dollar-rate
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.bitstamp.net/markets/eur/usd"
exit 0 # success
