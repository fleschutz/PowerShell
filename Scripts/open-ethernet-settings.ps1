<#
.SYNOPSIS
	Opens Windows Ethernet settings 
.DESCRIPTION
	This script launches the Windows Ethernet settings.
.EXAMPLE
	PS> ./open-ethernet-settings
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process ms-settings:network-ethernet
exit 0 # success
