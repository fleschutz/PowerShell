<#
.SYNOPSIS
	write-uppercase.ps1 [<text>]
.DESCRIPTION
	Writes the given text in uppercase letters
.EXAMPLE
	PS> .\write-uppercase.ps1 "Hello World"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

param([string]$Text = "")

if ($Text -eq "" ) { $Text = read-host "Enter the text to write" }

write-output $Text.ToUpper()
exit 0
