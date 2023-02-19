<#
.SYNOPSIS
	Installs basic apps
.DESCRIPTION
	This PowerShell script installs basic Windows apps such as browser, e-mail client, etc.
	Apps from the Microsoft Store are preferred (due to security and automatic updates). 
.EXAMPLE
	PS> ./install-basic-apps
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ Step 1 - Loading Data/basic-apps.csv..."
	$Table = Import-CSV "$PSScriptRoot/../Data/basic-apps.csv"
	$NumEntries = $Table.count
	Write-Host "   The following $NumEntries basic apps will be installed or upgraded: " -NoNewline
	foreach($Row in $Table) {
		[string]$AppName = $Row.APPLICATION
		Write-Host "$AppName, " -NoNewline
	}
	""
	"Press <Control> <C> to abort, otherwise the installation will start in 10 seconds..."
	sleep -s 10

	[int]$Step = 2
	[int]$Failed = 0
	foreach($Row in $Table) {
		[string]$AppName = $Row.APPLICATION
		[string]$Category = $Row.CATEGORY
		[string]$AppID = $Row.APPID

		"⏳ ($Step/$($NumEntries + 1)) Installing $AppName ($Category)..."
		& winget install --id $AppID --accept-package-agreements --accept-source-agreements
        	if ($lastExitCode -ne "0") { Write-Warning "'winget install' for $AppName failed"; $Failed++ }
		$Step++
	}
	[int]$Installed = ($NumEntries - $Failed)
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ installed $Installed basic apps in $Elapsed sec. ($Failed failed)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
