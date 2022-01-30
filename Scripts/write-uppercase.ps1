<#
.SYNOPSIS
	Writes text in uppercase letters
.DESCRIPTION
	This PowerShell script writes text in uppercase letters.
.PARAMETER text
	Specifies the text to write
.EXAMPLE
	PS> ./write-uppercase "Hello World"
.NOTES
	Author: Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$text = "")

if ($text -eq "" ) { $text = read-host "Enter the text to write" }

write-output $text.ToUpper()
exit 0 # success
