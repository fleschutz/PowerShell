<#
.SYNOPSIS
	Explains an abbreviation
.DESCRIPTION
	This PowerShell script queries the description of the given abbreviation and prints it.
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

	$Files = (Get-ChildItem "$PSScriptRoot/../Data/Abbr/*.csv")
	[int]$Matches = 0
	foreach($File in $Files) {
		$Table = Import-CSV "$File"
		foreach($Row in $Table) {
			if ($Row.ABBR -eq $abbr) {
				$Basename = (Get-Item "$File").Basename -Replace "_"," "
				"💡 $($Row.ABBR) in $Basename refers to: $($Row.TERM)"
				$Matches++
			}
		}
	}
	if ($Matches -eq 0) { "Sorry, '$abbr' is missing in the database." }
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
