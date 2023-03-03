<#
.SYNOPSIS
	Query app details
.DESCRIPTION
	This PowerShell script queries application details and lists it.
.EXAMPLE
	PS> ./check-apps
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		# TODO
	} else {
		Write-Progress "⏳ Querying installed apps & updates..."
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