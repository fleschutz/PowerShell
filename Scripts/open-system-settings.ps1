<#
.SYNOPSIS
	Opens system settings of Windows
.DESCRIPTION
	This script starts the system settings of Windows.
.EXAMPLE
	PS> ./open-system-settings
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process ms-settings:
exit 0 # success
