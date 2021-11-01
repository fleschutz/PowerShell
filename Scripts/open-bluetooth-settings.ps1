<#
.SYNOPSIS
	Opens Windows Bluetooth settings 
.DESCRIPTION
	This script launches the Windows Bluetooth settings application.
.EXAMPLE
	PS> ./open-bluetooth-settings
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process ms-settings:bluetooth
exit 0 # success
