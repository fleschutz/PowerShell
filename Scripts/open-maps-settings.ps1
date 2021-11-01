<#
.SYNOPSIS
	Opens Windows maps settings 
.DESCRIPTION
	This script launches the Windows maps settings.
.EXAMPLE
	PS> ./open-maps-settings
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process ms-settings:maps
exit 0 # success
