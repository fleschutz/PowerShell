<#
.SYNOPSIS
	Writes text in a red foreground color
.DESCRIPTION
	write-red.ps1 [<text>]
.EXAMPLE
	PS> ./write-red "Hello World"
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$text = "")

if ($text -eq "" ) { $text = read-host "Enter the text to write" }

write-host -foregroundcolor red "$text"
exit 0 # success
