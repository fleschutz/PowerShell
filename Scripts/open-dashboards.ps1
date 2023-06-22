<#
.SYNOPSIS
	Open Web dashboards
.DESCRIPTION
	This PowerShell script launches the Web browser with tabs of popular dashboard websites.
.EXAMPLE
	PS> ./open-dashboards.ps1
	⏳ (1/2) Loading Data/web-dashboards.csv...
	⏳ (2/2) Launching Web browser with tabs... Toggl Track · Google Calendar · CNN News...
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	Write-Host "⏳ (1/2) Loading Data/web-dashboards.csv..."
	$table = Import-CSV "$PSScriptRoot/../Data/web-dashboards.csv"
	$numRows = $table.Length
	Write-Host "⏳ (2/2) Launching Web browser with tabs... " -noNewline
	foreach($row in $table) {
		Write-Host "$($row.NAME) · " -noNewline
		& "$PSScriptRoot/open-default-browser.ps1" "$($row.URL)"
		Start-Sleep -milliseconds 100
	}
	Write-Host ""
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ opened $NumRows Web dashboards in $elapsed sec (Hint: use switch-tabs.ps1 to switch between browser tabs automatically)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}