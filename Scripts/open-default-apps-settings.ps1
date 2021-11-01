<#
.SYNOPSIS
	Opens Windows default apps settings 
.DESCRIPTION
	This script launches the Windows default apps settings.
.EXAMPLE
	PS> ./open-default-apps-settings
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process ms-settings:defaultapps
exit 0 # success
