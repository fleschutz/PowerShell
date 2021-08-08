<#
.SYNOPSIS
	write-quote.ps1 
.DESCRIPTION
	Writes a random quote to the console.
.EXAMPLE
	PS> .\write-quote.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

try {
	$Table = import-csv "$PSScriptRoot/../Data/quotes.csv"
	$NumRows = $Table.count

	$Generator = New-Object System.Random
	$Index = [int]$Generator.next(0,$NumRows - 1)
	$Quote = $Table[$Index].Quote
	$Author = $Table[$Index].Author

	"📣 $Quote <$Author>"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
