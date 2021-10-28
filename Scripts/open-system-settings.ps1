<#
.SYNOPSIS
	Opens Windows system settings 
.DESCRIPTION
	This script launches the Windows system settings application.
.EXAMPLE
	PS> ./open-system-settings
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process ms-settings:
exit 0 # success
