<#
.SYNOPSIS
	write-joke.ps1 
.DESCRIPTION
	Writes a random Juck Norris joke to the console.
.EXAMPLE
	PS> .\write-joke.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
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
