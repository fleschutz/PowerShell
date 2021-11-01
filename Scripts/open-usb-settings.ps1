<#
.SYNOPSIS
	Opens Windows USB settings 
.DESCRIPTION
	This script launches the Windows USB settings application.
.EXAMPLE
	PS> ./open-usb-settings
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process ms-settings:usb
exit 0 # success
