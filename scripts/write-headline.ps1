<#
.SYNOPSIS
	Writes a headline
.DESCRIPTION
	This PowerShell script writes the given text as a headline.
.PARAMETER text
	Specifies the text to write
.EXAMPLE
	PS> ./write-headline.ps1 "Hello World"
	-----------------
	   Hello World  
	-----------------
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "")

try {
	if ($text -eq "") { $text = Read-Host "Enter the text to write" }

	[int]$len = $text.Length
	[string]$line = "------"
	for ([int]$i = 0; $i -lt $len; $i++) { $line += "-" }
	Write-Host "`n$line`n   $text`n$line" -foregroundColor green
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
