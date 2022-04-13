<#
.SYNOPSIS
	Tells a joke by text-to-speech
.DESCRIPTION
	This PowerShell script selects a random Chuck Norris joke in Data/jokes.csv and speaks it by text-to-speech (TTS).
.EXAMPLE
	PS> ./tell-joke
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	$Table = import-csv "$PSScriptRoot/../Data/jokes.csv"

	$Generator = New-Object System.Random
	$Index = [int]$Generator.next(0, $Table.Count - 1)
	$Reply = $Table[$Index].Joke

	& "$PSScriptRoot/give-reply.ps1" "$Reply"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
