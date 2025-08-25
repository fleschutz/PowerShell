<#
.SYNOPSIS
	Uninstalls all apps
.DESCRIPTION
	This PowerShell script uninstalls all applications from the local computer. Useful for de-bloating Windows to clean up a PC quickly for an industrial use case without any security risks.
.EXAMPLE
	PS> ./uninstall-all-apps
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Uninstalling all apps, please wait... (ignore any error messages about packages that can't be removed, it's fine)"

	Get-AppxPackage | Remove-AppxPackage
	
	"Uninstalled all applications, your PC is clean now."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
