<#
.SYNOPSIS
	Query application details
.DESCRIPTION
	This PowerShell script queries and lists application details.
.EXAMPLE
	PS> ./check-apps
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$NumAppsInstalled = (Get-AppxPackage).Count
	$NumUpdates = (winget upgrade).Count - 5
	"✅ $NumAppsInstalled apps installed, $NumUpdates updates available"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}