<#
.SYNOPSIS
	speak-quote.ps1
.DESCRIPTION
	Speaks a random quote by text-to-speech (TTS)
.EXAMPLE
	PS> ./speak-quote
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$Table = import-csv "$PSScriptRoot/../Data/quotes.csv"
	$NumRows = $Table.count

	$Generator = New-Object System.Random
	$Index = [int]$Generator.next(0,$NumRows - 1)
	$Quote = $Table[$Index].Quote
	$Author = $Table[$Index].Author

	& "$PSScriptRoot/speak-english.ps1" "$Quote (by $Author)"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
