<#
.SYNOPSIS
	Opens the Booking.com website
.DESCRIPTION
	This script launches the Web browser with the Booking.com website.
.EXAMPLE
	PS> ./open-booking-com
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.booking.com"
exit 0 # success
