<#
.SYNOPSIS
	Installs basic apps
.DESCRIPTION
	This PowerShell script installs basic Windows apps (browser, e-mail client, etc).
.EXAMPLE
	PS> ./install-basic-apps
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ Step 1 - Loading Data/basic-apps.csv (CSV table)..."
	$Table = Import-CSV "$PSScriptRoot/../Data/basic-apps.csv"
	$NumEntries = $Table.count
	"Found $NumEntries entries."

	[int]$Step = 2
	foreach($Row in $Table) {
		[string]$AppName = $Row.AppName
		[string]$Category = $Row.Category
		[string]$AppID = $Row.AppID

		"⏳ Step $Step/$($NumEntries + 1) - Installing $AppName ($Category)..."
		& winget install --id $AppID --accept-package-agreements --accept-source-agreements
        	if ($lastExitCode -ne "0") { throw "'winget install' failed" }
		$Step++
	}
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ installed $NumEntries basic apps in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}