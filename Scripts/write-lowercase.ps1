<#
.SYNOPSIS
	Writes text in lowercase letters
.DESCRIPTION
	write-lowercase.ps1 [<text>]
.EXAMPLE
	PS> ./write-lowercase "Hello World"
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$text = "")

if ($text -eq "" ) { $text = read-host "Enter the text to write" }

write-output $text.ToLower()
exit 0 # success
