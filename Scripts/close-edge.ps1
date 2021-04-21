<#
.SYNTAX       close-edge.ps1 
.DESCRIPTION  closes Microsoft Edge gracefully
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

& "$PSScriptRoot/close-program.ps1" "Microsoft Edge" "msedge" "msedge"
exit 0
