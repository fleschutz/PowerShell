<#
.SYNOPSIS
	Opens the PayPal website
.DESCRIPTION
	This script launches the Web browser with the PayPal website.
.EXAMPLE
	PS> ./open-pay-pal-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.paypal.com"
exit 0 # success
