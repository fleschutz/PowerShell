<#
.SYNOPSIS
	Describes an abbreviation
.DESCRIPTION
	This PowerShell script queries and prints a description of the given abbreviation.
.PARAMETER abbr
	Specifies the abbreviation to look for
.EXAMPLE
	PS> ./what-is IAS
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$abbr = "")

try {
	if ($abbr -eq "" ) { $abbr = Read-Host "Enter the abbreviation" }

	$Missing = $true
	$Files = (Get-ChildItem "$PSScriptRoot/../Data/Abbr/*.csv")
	foreach ($File in $Files) {
		$Table = Import-CSV "$File"
		foreach($Row in $Table) {
			if ($Row.ABBR -eq $abbr) {
				$Basename = (Get-Item "$File").Basename -Replace "_"," "
				"💡 In $Basename $($Row.ABBR) may refer to $($Row.TERM)."
				$Missing = $false
			}
		}
	}
	if ($Missing) { "Sorry, '$abbr' is missing in the database." }
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
