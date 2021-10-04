<#
.SYNOPSIS
	Writes text in uppercase letters
.DESCRIPTION
	write-uppercase.ps1 [<text>]
.EXAMPLE
	PS> ./write-uppercase "Hello World"
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$text = "")

if ($text -eq "" ) { $text = read-host "Enter the text to write" }

write-output $text.ToUpper()
exit 0 # success
