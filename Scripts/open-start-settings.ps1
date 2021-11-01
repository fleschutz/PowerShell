<#
.SYNOPSIS
	Opens Windows start settings 
.DESCRIPTION
	This script launches the Windows start settings.
.EXAMPLE
	PS> ./open-start-settings
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process ms-settings:personalization-start
exit 0 # success
