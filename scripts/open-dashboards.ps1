<#
.SYNOPSIS
	Open Web dashboards
.DESCRIPTION
	This PowerShell script launches the Web browser with 24 tabs of popular dashboard websites.
.PARAMETER timeInterval
	Specifies the time interval between each tab (110ms per default)
.EXAMPLE
	PS> ./open-dashboards.ps1
	⏳ Launching Web browser with 24 new tabs: Toggl Track, Google Calendar, Google Mail,...
	💡 Hint: use './switch-tabs.ps1' to automatically switch from tab to tab.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

param([int]$timeInterval = 120) # milliseconds

try {
	Write-Progress "Reading Data/popular-dashboards.csv..."
	$table = Import-CSV "$PSScriptRoot/../data/popular-dashboards.csv"
	$numRows = $table.Count
	Write-Progress -completed "Done."

	Write-Host "⏳ Launching Web browser with $numRows new tabs: " -noNewline
	foreach($row in $table) {
		Write-Host "$($row.NAME), " -noNewline
		& "$PSScriptRoot/open-default-browser.ps1" "$($row.URL)"
		Start-Sleep -milliseconds $timeInterval
	}
	Write-Host ""
	Write-Host "💡 Hint: use './switch-tabs.ps1' to automatically switch from tab to tab."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
