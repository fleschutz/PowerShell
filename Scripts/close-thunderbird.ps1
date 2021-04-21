<#
.SYNTAX       close-thunderbird.ps1 
.DESCRIPTION  closes Mozilla Thunderbird gracefully
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

& "$PSScriptRoot/close-program.ps1" "Mozilla Thunderbird" "thunderbird" "thunderbird"
exit 0
