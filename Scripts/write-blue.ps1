<#
.SYNOPSIS
	write-blue.ps1 [<text>]
.DESCRIPTION
	Writes the given text in a blue foreground color
.EXAMPLE
	PS> .\write-blue.ps1 "Hello World"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

param([string]$Text = "")

if ($Text -eq "" ) { $Text = read-host "Enter the text to write" }

write-host -foregroundColor blue "$Text"

exit 0
