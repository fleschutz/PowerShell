<#
.SYNOPSIS
	Writes text in lowercase letters
.DESCRIPTION
	This PowerShell script writes text in lowercase letters.
.PARAMETER text
	Specifies the text to write
.EXAMPLE
	PS> ./write-lowercase "Hello World"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "")

if ($text -eq "" ) { $text = read-host "Enter the text to write" }

write-output $text.ToLower()
exit 0 # success
