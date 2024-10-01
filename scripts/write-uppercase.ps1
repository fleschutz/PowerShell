<#
.SYNOPSIS
	Writes text in uppercase letters
.DESCRIPTION
	This PowerShell script writes the given text in uppercase letters.
.PARAMETER text
	Specifies the text to write (ask user by default)
.EXAMPLE
	PS> ./write-uppercase.ps1 "Hello World"
	HELLO WORLD
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "")

if ($text -eq "" ) { $text = Read-Host "Enter the text to write" }

Write-Output $text.ToUpper()
exit 0 # success
