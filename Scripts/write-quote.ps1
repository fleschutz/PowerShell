<#
.SYNOPSIS
	Writes a random quote to the console
.DESCRIPTION
	This PowerShell script writes a random quote to the console.
.EXAMPLE
	PS> ./write-quote
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$Table = import-csv "$PSScriptRoot/../Data/quotes.csv"

	$Generator = New-Object System.Random
	$Index = [int]$Generator.next(0, $Table.Count - 1)
	$Quote = $Table[$Index].Quote
	$Author = $Table[$Index].Author

	""
	write-host '“'$Quote' ”'
	$Spaces = "                                                                                       "
	$Spaces = $Spaces.Substring(0, $Quote.Length - $Author.Length)
	"$Spaces    $($Author.toUpper())"
	
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
