<#
.SYNOPSIS
	Lists updates
.DESCRIPTION
	This PowerShell script lists available software updates for the local machine.
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
		"⏳ (1/2) Querying package updates... (use install-updates.ps1 to install them)"
		& sudo apt update
		& sudo apt list --upgradable
		"⏳ (2/2) Querying Snap updates... (use install-updates.ps1 to install them)"
		sudo snap refresh --list
	} else {
		Write-Progress "⏳ Querying available software updates..."
		" "
		& winget upgrade
		Write-Progress -completed "."
		Write-Host "(use install-updates.ps1 to install these updates)"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
