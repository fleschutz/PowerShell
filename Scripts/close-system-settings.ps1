<#
.SYNOPSIS
	Closes the System Settings window
.DESCRIPTION
	This script closes the System Settings window gracefully.
.EXAMPLE
	PS> ./close-system-settings
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "System Settings" "SystemSettings" "SystemSettings"
exit 0 # success
