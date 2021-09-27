<#
.SYNOPSIS
	write-green.ps1 [<text>]
.DESCRIPTION
	Writes the given text in a green foreground color
.EXAMPLE
	PS> ./write-green "Hello World"
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$text = "")

if ($text -eq "" ) { $text = read-host "Enter the text to write" }

write-host -foregroundColor green "$text"
exit 0 # success
