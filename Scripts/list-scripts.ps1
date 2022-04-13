<#
.SYNOPSIS
	Lists all PowerShell scripts in this repository
.DESCRIPTION
	This PowerShell script lists all PowerShell scripts in the repository (sorted alphabetically).
.EXAMPLE
	PS> ./list-scripts
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

function ListScripts { param([string]$FilePath)
	write-progress "Reading $FilePath..."
	$Table = import-csv "$FilePath"
	foreach($Row in $Table) {
		New-Object PSObject -Property @{
			'PowerShell Script' = "$($Row.Script)"
			'Description' = "$($Row.Description)"
		}
	}
	$global:NumScripts = $Table.Count
	write-progress -completed "Reading $FilePath..."
}

try {
	$PathToRepo = "$PSScriptRoot/.."
	ListScripts "$PathToRepo/Data/scripts.csv" | format-table -property "PowerShell Script",Description

	"✔️ $($global:NumScripts) PowerShell scripts total"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
