<#
.SYNOPSIS
	Uninstalls the new Outlook
.DESCRIPTION
	This PowerShell script uninstalls the new Outlook for Windows application.
.EXAMPLE
	PS> ./uninstall-new-outlook.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"⏳ Uninstalling new Outlook for Windows..."

	Remove-AppxProvisionedPackage -AllUsers -Online -PackageName (Get-AppxPackage Microsoft.OutlookForWindows).PackageFullName
	
	"✅ New Outlook for Windows has been removed."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
