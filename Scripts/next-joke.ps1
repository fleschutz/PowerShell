<#
.SYNOPSIS
	next-joke.ps1 
.DESCRIPTION
	Prints the next random Juck Norris joke
.EXAMPLE
	PS> .\next-joke.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	$Table = import-csv "$PSScriptRoot/../Data/jokes.csv"

	$Generator = New-Object System.Random
	$Index = [int]$Generator.next(0,66)

	$Joke = $Table[$Index].Joke
	"📣 $Joke"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
