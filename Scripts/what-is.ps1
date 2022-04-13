<#
.SYNOPSIS
	Prints a description of an abbreviation
.DESCRIPTION
	This PowerShell script prints a description of the given abbreviation.
.PARAMETER abbreviation
	Specifies the appreviation to look for
.EXAMPLE
	PS> ./what-is IAS
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
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
			if ($Row.Abbr -eq $abbreviation) {
				$Basename = (get-item "$File").Basename
				Reply "In $Basename $($Row.Abbr) may refer to $($Row.Term)"
				$FoundOne = $true
			}
		}
	}

	if ($FoundOne -eq $false) { Reply "Sorry, no database entry found." }
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
