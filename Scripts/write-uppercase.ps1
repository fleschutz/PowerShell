<#
.SYNTAX       write-uppercase.ps1 [<text>]
.DESCRIPTION  writes the given text in uppercase letters
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Text = "")
if ($Text -eq "" ) { $Text = read-host "Enter the text to write" }

write-output $Text.ToUpper()
exit 0
