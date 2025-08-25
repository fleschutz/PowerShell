<#
.SYNOPSIS
	Converts a .CSV file into a text file
.DESCRIPTION
	This PowerShell script converts a .CSV file into a text file and prints it.
.PARAMETER Path
	Specifies the path to the .CSV file
.EXAMPLE
	PS> ./convert-csv2txt salaries.csv
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$Path = "")

try {
	if ($Path -eq "" ) { $Path = read-host "Enter path to CSV file" }

	$Table = Import-CSV -path "$Path" -header A,B,C,D,E,F,G,H

	foreach($Row in $Table) {
		write-output "* $($Row.A) $($Row.B) $($Row.C) $($Row.D) $($Row.E) $($Row.F) $($Row.G) $($Row.H)"
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
