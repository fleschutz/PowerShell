<#
.SYNOPSIS
	Query application details
.DESCRIPTION
	This PowerShell script queries application details and list it.
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
		Write-Progress "⏳ (1/2) Querying installed apps (for current user only)..."
		$Apps = Get-AppxPackage
		[int]$NumInstalled = $Apps.Count
		[int]$NumIssues = 0
		foreach($App in $Apps) {
			if ($App.Status -ne "Ok") { $NumIssues++ }
		}

		Write-Progress "⏳ (2/2) Querying available updates..."
		$NumUpdates = (winget upgrade --include-unknown).Count - 5

		Write-Progress -Completed " "
		[int]$NumErrors = (Get-AppxLastError)
		"✅ $NumInstalled apps installed, $NumIssues non-ok, $NumErrors errors, $NumUpdates updates available"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}