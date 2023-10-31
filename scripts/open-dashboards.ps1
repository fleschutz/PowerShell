<#
.SYNOPSIS
	Open web dashboards
.DESCRIPTION
	This PowerShell script launches the Web browser with 20 tabs of popular dashboard websites.
.EXAMPLE
	PS> ./open-dashboards.ps1
	✅ Launching Web browser with 20 tabs showing: Toggl Track, Google Calendar, Google Mail, Google Keep, Google Photos, Google News, Outlook Mail, CNN News, GitHub Explore, FlightRadar24, Earthquake Watch, Live Cyber Threat Map, Live Traffic, Netflix Top 10, YouTube Music Charts, Webcams, Peak Zugspitze, Airport Salzburg, Windy Weather Radar, Windy Weather Temperatures, (Hint: execute './switch-tabs.ps1' for automated tab switching)
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Write-Progress "Reading Data/popular-dashboards.csv..."
	$table = Import-CSV "$PSScriptRoot/../data/popular-dashboards.csv"
	$numRows = $table.Length
	Write-Progress -completed " "
	Write-Host "✅ Launching Web browser with 20 tabs showing: " -noNewline
	foreach($row in $table) {
		Write-Host "$($row.NAME), " -noNewline
		& "$PSScriptRoot/open-default-browser.ps1" "$($row.URL)"
		Start-Sleep -milliseconds 100
	}
	Write-Host "(Hint: execute './switch-tabs.ps1' for automated tab switching)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
