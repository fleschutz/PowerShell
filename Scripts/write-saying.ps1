<#
.SYNOPSIS
	write-saying.ps1 
.DESCRIPTION
	Writes a random saying to the console.
.EXAMPLE
	PS> .\write-saying.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

try {
	$Table = import-csv "$PSScriptRoot/../Data/sayings.csv"

	$Generator = New-Object System.Random
	$Index = [int]$Generator.next(0,66)

	$Line = $Table[$Index].Saying
	"📣 $Line"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
