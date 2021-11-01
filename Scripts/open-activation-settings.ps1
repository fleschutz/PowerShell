<#
.SYNOPSIS
	Opens Windows activation settings 
.DESCRIPTION
	This script launches the Windows activation settings.
.EXAMPLE
	PS> ./open-activation-settings
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process ms-settings:activation
exit 0 # success
