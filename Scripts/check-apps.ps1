<#
.SYNOPSIS
	Query the app status
.DESCRIPTION
	This PowerShell script queries the application status and prints it.
.EXAMPLE
	PS> ./check-apps
	✅ 119 apps installed, 11 upgrades available
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		# TODO
	} else {
		Write-Progress "⏳ Querying installed apps and updates..."
		$Apps = Get-AppxPackage
		$Status = "✅ $($Apps.Count) apps installed"

		[int]$NumNonOk = 0
		foreach($App in $Apps) { if ($App.Status -ne "Ok") { $NumNonOk++ } }
		if ($NumNonOk -gt 0) { $Status += ", $NumNonOk non-ok" }
		[int]$NumErrors = (Get-AppxLastError)
		if ($NumErrors -gt 0) { $Status += ", $NumErrors errors" }

		$NumUpdates = (winget upgrade --include-unknown).Count - 5
		Write-Progress -Completed "."
		Write-Host "$Status, $NumUpdates upgrades available"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}