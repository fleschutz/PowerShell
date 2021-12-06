<#
.SYNOPSIS
	Prints a description of an abbreviation
.DESCRIPTION
	This script prints a description of the given abbreviation.
.PARAMETER abbreviation
	Specifies the appreviation to look for
.EXAMPLE
	PS> ./what-is IAS
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$abbreviation = "")

function Reply { param([string]$Text)
	& "$PSScriptRoot/give-reply.ps1" "$Text"
}

try {
	if ($abbreviation -eq "" ) { $abbreviation = read-host "Enter the abbreviation" }

	$FoundOne = $false
	$Files = (get-childItem "$PSScriptRoot/../Data/Abbr/*.csv")

	foreach ($File in $Files) {
		$Table = import-csv "$File"
		foreach($Row in $Table) {
			if ($Row.Abbreviation -eq $abbreviation) {
				$Basename = (get-item "$File").Basename
				Reply "$($Row.Definition) ($($Row.Abbreviation)) in $Basename"
				$FoundOne = $true
			}
		}
	}

	if ($FoundOne -eq $false) { Reply "Sorry, no database entry found." }
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
