<#
.SYNOPSIS
	Lists your remembered entries
.DESCRIPTION
	This PowerShell script lists all entries in 'Remember.csv' in your home folder.
.EXAMPLE
	PS> ./list-memos.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$path = "~/Remember.csv"
	if (-not(Test-Path "$path" -pathType leaf)) {
		"Nothing to remember."
		exit 1
	}

	Write-Progress "Reading $path ..."
	$table = Import-CSV "$path"
	Write-Progress -completed "Done."

	foreach($row in $table) {
  		$unixTimestamp = [int64]$row.TIMESTAMP
                $time = (Get-Date -day 1 -month 1 -year 1970 -hour 0 -minute 0 -second 0).AddSeconds($unixTimestamp)
		$text = $row.TEXT.trim()
		"⚠️ NOTE: $text (remembered $time)"
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
