#!/snap/bin/powershell
<#
.SYNTAX         ./list-scripts.ps1
.DESCRIPTION	lists the PowerShell scripts in this repository
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

function ListScripts { param([string]$FilePath)
	write-progress "Reading $FilePath..."
	$Table = import-csv "$FilePath"
	foreach($Row in $Table) {
		New-Object PSObject -Property @{
			'Script' = "$($Row.Filename)"
			'Description' = "$($Row.Description)"
		}
	}
	write-progress -completed "Reading $FilePath..."
	write-output ""
	write-output "($($Table.Count) PowerShell scripts total)"
}

try {
	$PathToRepo = "$PSScriptRoot/.."
	ListScripts "$PathToRepo/Data/scripts.csv" | format-table -property Script, Description
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
