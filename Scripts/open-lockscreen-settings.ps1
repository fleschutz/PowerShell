<#
.SYNOPSIS
	Opens Windows lockscreen settings 
.DESCRIPTION
	This script launches the Windows lockscreen settings application.
.EXAMPLE
	PS> ./open-lockscreen-settings
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process ms-settings:lockscreen
exit 0 # success
