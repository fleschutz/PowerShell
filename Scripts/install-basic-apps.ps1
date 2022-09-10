<#
.SYNOPSIS
	Installs basic apps
.DESCRIPTION
	This PowerShell script installs basic Windows apps (browser, e-mail client, etc).
	Apps from the Microsoft Store are preferred for automatic updates. 
.EXAMPLE
	PS> ./install-basic-apps
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ Step 1 - Loading table from Data/basic-apps.csv..."
	$Table = Import-CSV "$PSScriptRoot/../Data/basic-apps.csv"
	$NumEntries = $Table.count
	Write-Host "   About to install $NumEntries apps: " -NoNewline
	foreach($Row in $Table) {
		[string]$AppName = $Row.AppName
		Write-Host "$AppName, " -NoNewline
	}
	""
	"Press <Control> <C> to abort, otherwise the installation will start..."
	sleep -s 3

	[int]$Step = 2
	foreach($Row in $Table) {
		[string]$AppName = $Row.AppName
		[string]$Category = $Row.Category
		[string]$AppID = $Row.AppID

		"⏳ Step $Step/$($NumEntries + 1) - Installing $AppName ($Category)..."
		& winget install --id $AppID --accept-package-agreements --accept-source-agreements
        	if ($lastExitCode -ne "0") { throw "'winget install' for $AppName failed" }
		$Step++
	}
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ installed $NumEntries apps in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}