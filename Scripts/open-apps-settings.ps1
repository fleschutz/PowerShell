<#
.SYNOPSIS
	Opens Windows apps settings 
.DESCRIPTION
	This script launches the Windows aps settings.
.EXAMPLE
	PS> ./open-apps-settings
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process ms-settings:appsfeatures
exit 0 # success
