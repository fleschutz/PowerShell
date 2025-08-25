<#
.SYNOPSIS
	Uninstalls Outlook
.DESCRIPTION
	This PowerShell script uninstalls Outlook for Windows.
.EXAMPLE
	PS> ./uninstall-outlook.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"⏳ Uninstalling Outlook for Windows..."

	Remove-AppxPackage -AllUsers -Package (Get-AppxPackage Microsoft.OutlookForWindows).PackageFullName
	
	"✅ Outlook for Windows has been removed."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
