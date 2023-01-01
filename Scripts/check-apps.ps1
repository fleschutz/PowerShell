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
		Write-Progress "⏳ Querying installed apps..."
		$Apps = Get-AppxPackage
		[int]$NumInstalled = $Apps.Count
		[int]$NumIssues = 0
		foreach($App in $Apps) {
			if ($App.Status -ne "Ok") { $NumIssues++ }
		}

		Write-Progress "⏳ Querying available updates..."
		$NumUpdates = (winget upgrade --include-unknown).Count - 5

		[int]$NumErrors = (Get-AppxLastError)
		Write-Host "✅ $NumInstalled apps installed, $NumIssues non-ok, $NumErrors errors, $NumUpdates updates available"
		Write-Progress -Completed " "
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}