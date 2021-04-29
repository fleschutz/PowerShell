<#
.SYNTAX       what-is.ps1 [<abbreviation>]
.DESCRIPTION  prints a description of the given abbreviation
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Abbreviation = "")
if ($Abbreviation -eq "" ) { $Abbreviation = read-host "Enter the abbreviation" }

try {
	write-progress "Searching ..."
	$FoundOne = 0

	$Table = import-csv "$PSScriptRoot/../Data/Abbr/Aviation.csv"
	foreach($Row in $Table) {
		if ($Row.Abbr -eq $Abbreviation) {
			"Aviation: $($Row.Description)"
			$FoundOne = 1
		}
	}

	$Table = import-csv "$PSScriptRoot/../Data/Abbr/Misc.csv"
	foreach($Row in $Table) {
		if ($Row.Abbr -eq $Abbreviation) {
			"Misc: $($Row.Description)"
			$FoundOne = 1
		}
	}

	if ($FoundOne -eq 0) {
		"Sorry, no entry for $Abbreviation found"
	}
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
