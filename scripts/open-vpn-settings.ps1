<#
.SYNOPSIS
	Opens the VPN settings
.DESCRIPTION
	This PowerShell script launches the VPN settings of Windows.
.EXAMPLE
	PS> ./open-vpn-settings.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

Start-Process ms-settings:network-vpn
exit 0 # success
