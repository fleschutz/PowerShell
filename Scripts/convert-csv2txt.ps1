<#
.SYNOPSIS
	convert-csv2txt.ps1 [<csv-file>]
.DESCRIPTION
	Converts the given CSV file into a text list
.EXAMPLE
	PS> .\convert-csv2txt.ps1 salaries.csv
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

param([string]$Path = "")

try {
	if ($Path -eq "" ) { $Path = read-host "Enter path to CSV file" }

	$Table = Import-CSV -path "$Path" -header A,B,C,D,E,F,G,H

	foreach($Row in $Table) {
		write-output "* $($Row.A) $($Row.B) $($Row.C) $($Row.D) $($Row.E) $($Row.F) $($Row.G) $($Row.H)"
	}
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
