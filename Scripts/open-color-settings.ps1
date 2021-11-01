<#
.SYNOPSIS
	Opens Windows color settings 
.DESCRIPTION
	This script launches the Windows color settings.
.EXAMPLE
	PS> ./open-color-settings
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process ms-settings:colors
exit 0 # success
