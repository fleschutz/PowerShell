<#
.SYNOPSIS
	Opens Windows date & time settings 
.DESCRIPTION
	This script launches the Windows date & time settings.
.EXAMPLE
	PS> ./open-time-settings
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process ms-settings:dateandtime
exit 0 # success
