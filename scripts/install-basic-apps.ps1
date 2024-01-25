<#
.SYNOPSIS
	Installs basic apps
.DESCRIPTION
	This PowerShell script installs basic Windows apps such as browser, e-mail client, etc.
	NOTE: Apps from Microsoft Store are preferred (due to security and automatic updates). 
.EXAMPLE
	PS> ./install-basic-apps.ps1
	⏳ (1) Loading data/basic-apps.csv...    37 apps listed
	⏳ (2) Applications to install/upgrade:  7-Zip · Aquile Reader ...
	...
	✔️ Installed 37 basic apps (0 skipped) in 387 sec.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1) Loading data/basic-apps.csv...     " -noNewline
	$table = Import-CSV "$PSScriptRoot/../data/basic-apps.csv"
	$numEntries = $table.count
	"$numEntries apps listed"
	Write-Host "⏳ (2) Applications to install/upgrade:   " -noNewline
	foreach($row in $table) {
		[string]$appName = $row.APPLICATION
		Write-Host "$appName · " -noNewline
	}
	""
	""
	"The installation will start in 15 seconds or press <Control> <C> to abort..."
	Start-Sleep -seconds 15

	[int]$step = 3
	[int]$numSkipped = 0
	foreach($row in $table) {
		[string]$appName = $row.APPLICATION
		[string]$category = $row.CATEGORY
		[string]$appID = $row.APPID
		Write-Host " "
		Write-Host "⏳ ($step/$($numEntries + 2)) Installing $category '$appName'..."
		& winget install --id $appID --accept-package-agreements --accept-source-agreements
        	if ($lastExitCode -ne "0") { $numSkipped++ }
		$step++
	}
	[int]$numInstalled = ($numEntries - $numSkipped)
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✔️ Installed $numInstalled basic apps ($numSkipped skipped) in $elapsed sec."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
