<#
.SYNOPSIS
	Explains an abbreviation
.DESCRIPTION
	This PowerShell script queries the meaning of the given abbreviation and prints it.
.PARAMETER abbr
	Specifies the abbreviation to query
.EXAMPLE
	PS> ./what-is VTOL
	💡 VTOL in aviation refers to Vertical Take-Off and Landing
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$abbr = "")

try {
	if ($abbr -eq "" ) { $abbr = Read-Host "Enter the abbreviation to query" }
	$files = (Get-ChildItem "$PSScriptRoot/../data/abbr/*.csv")
	$basename = ""
	foreach($file in $files) {
		$table = Import-CSV "$file"
		foreach($row in $table) {
			if ($row.ABBR -ne $abbr) { continue }
			$basename = (Get-Item "$file").Basename -Replace "_"," "
			"💡 $($row.ABBR) in $basename refers to $($row.MEANING)"
		}
	}
	if ($basename -eq "") { "🤷‍ Sorry, no '$abbr' entry found. Use <Ctrl> <Click> to google it: https://www.google.com/search?q=abbreviation+$abbr" }
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
