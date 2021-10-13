<#
.SYNOPSIS
	Say a random Chuck Norris joke by text-to-speech
.DESCRIPTION
	This script selects a random joke in Data/jokes.csv and tells it by text-to-speech (TTS).
.EXAMPLE
	PS> ./say-joke
	(listen and have fun)
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$Table = import-csv "$PSScriptRoot/../Data/jokes.csv"

	$Generator = New-Object System.Random
	$Index = [int]$Generator.next(0, $Table.Count - 1)
	$Joke = $Table[$Index].Joke

	& "$PSScriptRoot/speak-english.ps1" "$Joke"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
