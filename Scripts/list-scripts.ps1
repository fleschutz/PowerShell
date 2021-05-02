<#
.SYNTAX       list-scripts.ps1
.DESCRIPTION  lists all PowerShell scripts in this repository (sorted alphabetically)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
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

	write-host -foregroundColor green "OK - $($global:NumScripts) PowerShell scripts total"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
