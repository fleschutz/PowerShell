<#
.SYNOPSIS
	Opens Windows themes settings 
.DESCRIPTION
	This script launches the Windows themes settings.
.EXAMPLE
	PS> ./open-themes-settings
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process ms-settings:themes
exit 0 # success
