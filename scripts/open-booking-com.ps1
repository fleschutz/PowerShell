<#
.SYNOPSIS
	Opens the Booking.com website
.DESCRIPTION
	This PowerShell script launches the Web browser with the Booking.com website.
.EXAMPLE
	PS> ./open-booking-com
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

& "$PSScriptRoot/open-default-browser.ps1" "https://www.booking.com"
exit 0 # success
