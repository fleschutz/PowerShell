<#
.SYNOPSIS
	close-system-settings.ps1 
.DESCRIPTION
	Closes the System Settings gracefully
.EXAMPLE
	PS> ./close-system-settings
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "System Settings" "SystemSettings" "SystemSettings"
exit 0 # success
