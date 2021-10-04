<#
.SYNOPSIS
	Writes a random Juck Norris joke to the console
.DESCRIPTION
	write-joke.ps1 
.EXAMPLE
	PS> ./write-joke
	When Chuck Norris does division, there are no remainders. 😂
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$Table = import-csv "$PSScriptRoot/../Data/jokes.csv"
	$NumRows = $Table.count

	$Generator = New-Object System.Random
	$Index = [int]$Generator.next(0,$NumRows - 1)
	$Joke = $Table[$Index].Joke

	"$Joke 😂"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
