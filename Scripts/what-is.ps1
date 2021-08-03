<#
.SYNOPSIS
	what-is.ps1 [<abbreviation>]
.DESCRIPTION
	Prints a description of the given abbreviation
.EXAMPLE
	PS> .\what-is.ps1 CIA
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

param([string]$Abbreviation = "")

try {
	if ($Abbreviation -eq "" ) { $Abbreviation = read-host "Enter the abbreviation" }

	write-progress "Searching ..."

	$FoundOne = $false
	$Files = (get-childItem "$PSScriptRoot/../Data/Abbr/*" -attributes !Directory)

	foreach ($File in $Files) {
		$Table = import-csv "$File"
		foreach($Row in $Table) {
			if ($Row.Abbreviation -eq $Abbreviation) {
				$Basename = (get-item "$File").Basename
				"  → $($Row.Abbreviation) = $($Row.Definition) in $Basename"
				$FoundOne = $true
			}
		}
	}

	if ($FoundOne -eq $false) { "Sorry, no entry for $Abbreviation found" }
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
