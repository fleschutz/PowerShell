<#
.SYNOPSIS
	Writes text in a green foreground color
.DESCRIPTION
	This PowerShell script writes text in a green foreground color.
.PARAMETER text
	Specifies the text to write
.EXAMPLE
	PS> ./write-green "Hello World"
.NOTES
	Author: Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$text = "")

if ($text -eq "" ) { $text = read-host "Enter the text to write" }

write-host -foregroundColor green "$text"
exit 0 # success
