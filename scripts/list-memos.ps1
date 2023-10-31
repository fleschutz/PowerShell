<#
.SYNOPSIS
	Lists your memo entries
.DESCRIPTION
	This PowerShell script lists all memo entries in Memos.csv in your home folder.
.EXAMPLE
	PS> ./list-memos.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>


try {
	$Path = "~/Memos.csv"
	if (Test-Path "$Path" -pathType leaf) {
		write-progress "Reading $Path ..."
		$Table = Import-CSV "$Path"
		write-progress -completed "Reading $Path"

		""
		"Time                  Text"
		"----                  ----"
		foreach($Row in $Table) {
			$Time = $Row.Time
			$Text = $Row.Text
			"$Time  $Text"
		}
	} else {
		"Sorry, no memos saved yet"
		exit 1
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
