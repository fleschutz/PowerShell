﻿<#
.SYNOPSIS
	Open Web dashboards
.DESCRIPTION
	This PowerShell script launches the Web browser with 24 tabs of popular dashboard websites.
.PARAMETER timeInterval
	Specifies the time interval between each tab (110ms per default)
.EXAMPLE
	PS> ./open-dashboards.ps1
	⏳ Launching Web browser with 24 tabs: Toggl Track•Google Calendar•Google Mail, ...
	NOTE: Execute './switch-tabs.ps1' to switch from tab to tab automatically.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([int]$timeInterval = 120) # milliseconds

try {
	Write-Progress "Reading Data/popular-dashboards.csv..."
	$table = Import-CSV "$PSScriptRoot/../data/popular-dashboards.csv"
	$numRows = $table.Count
	Write-Progress -completed "Done."

	Write-Host "⏳ Launching Web browser with $numRows tabs: " -noNewline
	foreach($row in $table) {
		Write-Host "$($row.NAME)•" -noNewline
		& "$PSScriptRoot/open-default-browser.ps1" "$($row.URL)"
		Start-Sleep -milliseconds $timeInterval
	}
	Write-Host ""
	Write-Host "NOTE: Execute './switch-tabs.ps1' to switch from tab to tab automatically."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
