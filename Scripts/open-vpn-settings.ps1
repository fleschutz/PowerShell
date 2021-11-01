<#
.SYNOPSIS
	Opens Windows VPN settings 
.DESCRIPTION
	This script launches the Windows VPN (virtual private network) settings.
.EXAMPLE
	PS> ./open-vpn-settings
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process ms-settings:network-vpn
exit 0 # success
