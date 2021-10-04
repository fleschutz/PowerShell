<#
.SYNOPSIS
	Prints a description of the given abbreviation
.DESCRIPTION
	what-is.ps1 [<abbreviation>]
.EXAMPLE
	PS> ./what-is CIA
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$abbreviation = "")

try {
	if ($abbreviation -eq "" ) { $abbreviation = read-host "Enter the abbreviation" }

	write-progress "Searching ..."

	$FoundOne = $false
	$Files = (get-childItem "$PSScriptRoot/../Data/Abbr/*" -attributes !Directory)

	foreach ($File in $Files) {
		$Table = import-csv "$File"
		foreach($Row in $Table) {
			if ($Row.Abbreviation -eq $abbreviation) {
				$Basename = (get-item "$File").Basename
				"  → $($Row.Abbreviation) = $($Row.Definition) in $Basename"
				$FoundOne = $true
			}
		}
	}

	if ($FoundOne -eq $false) { "Sorry, no entry for $abbreviation found" }
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
