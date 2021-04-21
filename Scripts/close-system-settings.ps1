<#
.SYNTAX       close-system-settings.ps1 
.DESCRIPTION  closes the System Settings gracefully
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

& "$PSScriptRoot/close-program.ps1" "System Settings" "SystemSettings" "SystemSettings"
exit 0
