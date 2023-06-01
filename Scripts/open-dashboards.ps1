<#
.SYNOPSIS
	Open dashboards
.DESCRIPTION
	This PowerShell script launches the Web browser with tabs of some dashboard websites.
.EXAMPLE
	PS> ./open-dashboards
	⏳ (1/2) Loading Data/popular-dashboards.csv...
	⏳ (2/2) Launching Web browser with tabs of dashboard websites...
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	Write-Host "⏳ (1/2) Loading Data/popular-dashboards.csv..."
	$Table = Import-CSV "$PSScriptRoot/../Data/popular-dashboards.csv"
	$NumRows = $Table.Length
	Write-Host "⏳ (2/2) Launching Web browser with tabs of dashboard websites...   "
	foreach($Row in $Table) {
		$Name = $Row.NAME
		$URL = $Row.URL
		Write-Host "$Name · " -noNewline
		& "$PSScriptRoot/open-default-browser.ps1" "$URL"
		Start-Sleep -milliseconds 50
	}
	Write-Host ""
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"Hint: use switch-tabs.ps1 to switch the browser tabs automatically"
	"✅ Opened $NumRows dashboards in $elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
