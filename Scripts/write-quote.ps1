<#
.SYNOPSIS
	Writes a quote
.DESCRIPTION
	This PowerShell script selects a random quote and prints it to the console.
.EXAMPLE
	PS> ./write-quote.ps1
	“ We must become the change we want to see. „
	                           - MAHATMA GANDHI
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$table = Import-CSV "$PSScriptRoot/../Data/quotes.csv"

	$randomNumberGenerator = New-Object System.Random
	$row = [int]$randomNumberGenerator.next(0, $table.Count - 1)
	$quote = $table[$row].QUOTE
	$author = $table[$row].AUTHOR.toUpper()
	$spaces = "                                                                                                                             "
	$spaces = $spaces.Substring(0, $quote.Length - $author.Length)

	Write-Host "`n"'“'"$quote"'„'"`n$spaces- $author"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
