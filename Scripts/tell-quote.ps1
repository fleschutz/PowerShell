<#
.SYNOPSIS
	Tells a quote by text-to-speech
.DESCRIPTION
	This PowerShell script selects a random quote in Data/quotes.csv and speaks it by text-to-speech (TTS).
.EXAMPLE
	PS> ./tell-quote
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	$Table = import-csv "$PSScriptRoot/../Data/quotes.csv"

	$Generator = New-Object System.Random
	$Index = [int]$Generator.next(0, $Table.Count - 1)
	$Quote = $Table[$Index].Quote
	$Author = $Table[$Index].Author
	$Reply = "$Quote (by $Author)"

	& "$PSScriptRoot/give-reply.ps1" "$Reply"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
