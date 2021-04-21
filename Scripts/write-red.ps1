<#
.SYNTAX       write-red.ps1 [<text>]
.DESCRIPTION  writes the given text in a red foreground color
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Text = "")
if ($Text -eq "" ) { $Text = read-host "Enter the text to write" }

write-host -foregroundcolor red "$Text"
exit 0
