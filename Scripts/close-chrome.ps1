<#
.SYNTAX       close-chrome.ps1 
.DESCRIPTION  closes Google Chrome gracefully
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

& "$PSScriptRoot/close-program.ps1" "Google Chrome" "chrome" "chrome"
exit 0
