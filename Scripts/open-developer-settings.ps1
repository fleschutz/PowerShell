<#
.SYNOPSIS
	Opens Windows developer settings 
.DESCRIPTION
	This script launches the Windows developer settings.
.EXAMPLE
	PS> ./open-developer-settings
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process ms-settings:developers
exit 0 # success
