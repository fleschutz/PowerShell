#!/bin/powershell
<#
.SYNTAX         ./next-joke.ps1 
.DESCRIPTION	gets the next random Juck Norris joke
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

try {
	$PathToRepo = "$PSScriptRoot/.."

	$Table = import-csv "$PathToRepo/Data/jokes.csv"

	$Generator = New-Object System.Random
	$Index = [int]$Generator.next(0,66)

	$Joke = $Table[$Index].Joke
	write-output "$Joke"
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
