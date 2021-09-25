<#
.SYNOPSIS
	write-quote.ps1 
.DESCRIPTION
	Writes a random quote to the console
.EXAMPLE
	PS> ./write-quote
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

	""
	write-host '“'$Quote' ”'
	$Spaces = "                                                                                       "
	$Spaces = $Spaces.Substring(0, $Quote.Length - $Author.Length)
	"$Spaces    $($Author.toUpper())"
	
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
