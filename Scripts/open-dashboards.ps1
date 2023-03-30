<#
.SYNOPSIS
	Open dashboards
.DESCRIPTION
	This PowerShell script launches the Web browser with some dashboard websites.
.EXAMPLE
	PS> ./open-dashboards
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$URLs = @("https://track.toggl.com/timer", "https://news.google.com", "https://www.windy.com/de/-Wetterradar-radar",
		"https://www.flightradar24.com/27.63,-6.98/3","https://www.arcgis.com/apps/dashboards/c8af9c5411814584b460cc87cb7c3780",
		"https://www.foto-webcam.eu", "https://zugspitze.panomax.com", "https://livecam.salzburg-airport.com",
		"https://sunnyportal.com/FixedPages/Dashboard.aspx", "https://covid19.who.int", "https://top10.netflix.com")

	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	"⏳ Opening Web dashboards in your browser..."
	foreach($URL in $URLs) {
		& "$PSScriptRoot/open-default-browser.ps1" "$URL"
		Start-Sleep -milliseconds 100
	}
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Opened 12 Web dashboards in $elapsed sec (use switch-tabs.ps1 to switch the tabs automatically)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
