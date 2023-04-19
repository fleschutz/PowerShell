<#
.SYNOPSIS
	Lists software updates
.DESCRIPTION
	This PowerShell script lists available updates for the local machine.
	Use "install-updates.ps1" to install the listed updates.
.EXAMPLE
	PS> ./list-updates
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		Write-Host "⏳ Querying package updates..."
		& sudo apt update
		& sudo apt list --upgradable
		Write-Host "⏳ Querying Snap updates..."
		sudo snap refresh --list
	} else {
		Write-Progress "⏳ Querying application updates..."
		" "
		& winget upgrade
		Write-Progress -Completed " "
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
