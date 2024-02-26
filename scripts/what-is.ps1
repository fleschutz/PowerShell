<#
.SYNOPSIS
	Explains a term/abbreviation/etc.
.DESCRIPTION
	This PowerShell script queries the meaning of the given term/abbreviation/etc. and prints it.
.PARAMETER term
	Specifies the term to query
.EXAMPLE
	PS> ./what-is VTOL
	💡 VTOL in aviation refers to Vertical Take-Off and Landing
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$term = "")

try {
	if ($term -eq "" ) { $term = Read-Host "Enter the term/abbreviation/etc. to query" }
	$files = (Get-ChildItem "$PSScriptRoot/../data/dicts/*.csv")
	$basename = ""
	foreach($file in $files) {
		$table = Import-CSV "$file"
		foreach($row in $table) {
			if ($row.TERM -ne $term) { continue }
			$basename = (Get-Item "$file").Basename -Replace "_"," "
			"💡 $($row.TERM) in $basename refers to: $($row.MEANING)"
		}
	}
	if ($basename -eq "") { "🤷‍ Sorry, no '$term' entry found. Use <Ctrl> <Click> to google it: https://www.google.com/search?q=what+is+$term" }
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
