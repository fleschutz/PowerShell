<#
.SYNOPSIS
	Writes text in a blue foreground color
.DESCRIPTION
	This script writes text in a blue foreground color.
.PARAMETER text
	Specifies the text to write
.EXAMPLE
	PS> ./write-blue "Hello World"
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$text = "")

if ($text -eq "" ) { $text = read-host "Enter the text to write" }

write-host -foregroundColor blue "$text"

exit 0 # success
