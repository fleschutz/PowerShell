<#
.SYNOPSIS
	Opens Windows background settings 
.DESCRIPTION
	This script launches the Windows background settings.
.EXAMPLE
	PS> ./open-background-settings
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process ms-settings:personalization-background
exit 0 # success
