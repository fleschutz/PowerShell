<#
.SYNOPSIS
	Writes a random joke
.DESCRIPTION
	This PowerShell script selects a random joke (from Data/jokes.csv) and writes it to the console.
.EXAMPLE
	PS> ./write-joke.ps1
	Chuck Norris can dribble a bowling ball. 😂
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$table = Import-CSV "$PSScriptRoot/../data/jokes.csv"

	$randomNumberGenerator = New-Object System.Random
	$rowNumber = [int]$randomNumberGenerator.next(0, $table.Count - 1)
	$joke = $table[$rowNumber].JOKE

	Write-Host "`n$Joke 😂" -foregroundColor Green
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
