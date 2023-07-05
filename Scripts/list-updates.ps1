<#
.SYNOPSIS
	Lists updates
.DESCRIPTION
	This PowerShell script queries and lists available software updates for the local machine.
	NOTE: use 'install-updates.ps1' to install the listed updates.
.EXAMPLE
	PS> ./list-updates
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		"⏳ (1/2) Querying package updates..."
		& sudo apt update
		& sudo apt list --upgradable
		"⏳ (2/2) Querying Snap updates..."
		& sudo snap refresh --list
	} else {
		" "
		Write-Progress "⏳ Querying available software updates..."
		& winget upgrade
		Write-Progress -completed "."
	}
	"NOTE: use 'install-updates.ps1' to install the listed updates."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
