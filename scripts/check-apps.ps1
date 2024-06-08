<#
.SYNOPSIS
	Query the app status
.DESCRIPTION
	This PowerShell script queries the installed applications and prints it.
.EXAMPLE
	PS> ./check-apps.ps1
	✅ 119 Windows apps installed, 11 upgrades available
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function GetCrashDumps {
	[string]$path = Resolve-Path -Path "~\AppData\Local\CrashDumps"
	$count = 0
	$files = (Get-ChildItem -path "$path\*.dmp" -attributes !Directory)
	foreach($file in $files) { $count++ }
	return $count
}

try {
	$statusIcon = "✅"
	$statusMsg = ""
	if ($IsLinux) {
		Write-Progress "Querying installed applications..."
		$numPkgs = (apt list --installed 2>/dev/null).Count
		$numSnaps = (snap list).Count - 1
		Write-Progress -completed "Done."
		$statusMsg += "$numPkgs Debian packages, $numSnaps snaps installed"
	} else {
		Write-Progress "Querying installed apps..."
		$Apps = Get-AppxPackage
		Write-Progress -completed "Done."
		$statusMsg = "$($Apps.Count) Win apps installed"

		[int]$numNonOk = 0
		foreach($App in $Apps) { if ($App.Status -ne "Ok") { $numNonOk++ } }
		if ($numNonOk -gt 0) { $statusIcon = "⚠️"; $statusMsg += ", $numNonOk non-ok" }

		[int]$numErrors = (Get-AppxLastError)
		if ($numErrors -gt 0) { $statusIcon = "⚠️"; $statusMsg += ", $numErrors errors" }

		$numUpdates = (winget upgrade --include-unknown).Count - 5
		$statusMsg += ", $numUpdates upgrades available"

		$crashDumps = GetCrashDumps
		if ($crashDumps -ne 0) { $statusIcon = "⚠️"; $statusMsg += " - found $crashDumps crash dump(s)" }
	}
	Write-Host "$statusIcon $statusMsg"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
