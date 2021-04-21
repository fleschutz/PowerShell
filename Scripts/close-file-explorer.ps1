<#
.SYNTAX       close-file-explorer.ps1 
.DESCRIPTION  closes Microsoft File Explorer gracefully
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

& "$PSScriptRoot/close-program.ps1" "File Explorer" "explorer" "explorer"
exit 0
