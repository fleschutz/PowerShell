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
	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	Write-Progress "⏳ Loading Data/popular-dashboards.csv..."
	$Table = Import-CSV "$PSScriptRoot/../Data/popular-dashboards.csv"
	$NumRows = $Table.Length
	foreach($Row in $Table) {
		$Name = $Row.NAME
		$URL = $Row.URL
		Write-Progress "⏳ Opening $Name in your browser..."
		& "$PSScriptRoot/open-default-browser.ps1" "$URL"
		Start-Sleep -milliseconds 100
	}
	Write-Progress -completed "."
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Opened $NumRows Web dashboards in $elapsed sec (use switch-tabs.ps1 to switch the tabs automatically)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
