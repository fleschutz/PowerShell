<#
.SYNOPSIS
	Speaks a random Chuck Norris joke by text-to-speech (TTS)
.DESCRIPTION
	speak-joke.ps1
.EXAMPLE
	PS> ./speak-joke
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

	& "$PSScriptRoot/speak-english.ps1" "$Joke"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
