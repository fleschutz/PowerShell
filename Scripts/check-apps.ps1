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
		Write-Progress "⏳ Querying installed applications..."
		$Apps = Get-AppxPackage
		[int]$NumInstalled = $Apps.Count
		[int]$NumNonOk = 0
		foreach($App in $Apps) { if ($App.Status -ne "Ok") { $NumNonOk++ } }

		Write-Progress "⏳ Querying application updates..."
		$NumUpdates = (winget upgrade --include-unknown).Count - 5

		[int]$NumErrors = (Get-AppxLastError)
		Write-Host "✅ $NumInstalled apps ($NumNonOk non-ok, $NumErrors errors, $NumUpdates updates available)"
		Write-Progress -Completed "Querying application updates finished."
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}