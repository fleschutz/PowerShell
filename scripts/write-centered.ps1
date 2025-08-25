<#
.SYNOPSIS
	Writes text centered
.DESCRIPTION
	This PowerShell script writes the given text centered to the console.
.PARAMETER text
	Specifies the text to write
.EXAMPLE
	PS> ./write-headline.ps1 "Hello World"
							Hello World
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "")

try {
	if ($text -eq "") { $text = Read-Host "Enter the text to write" }

	$ui = (Get-Host).ui
	$rui = $ui.rawui 
	[int]$numSpaces = ($rui.MaxWindowSize.Width - $text.Length) / 2

	[string]$spaces = ""
	for ([int]$i = 0; $i -lt $numSpaces; $i++) { $spaces += " " }
	Write-Host "$spaces$text"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
