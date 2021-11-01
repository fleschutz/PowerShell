<#
.SYNOPSIS
	Opens Windows WLAN settings 
.DESCRIPTION
	This script launches the Windows WLAN settings application.
.EXAMPLE
	PS> ./open-wifi-settings
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process ms-settings:network-wifi
exit 0 # success
