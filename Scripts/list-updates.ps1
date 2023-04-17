<#
.SYNOPSIS
	Lists software updates
.DESCRIPTION
	This PowerShell script lists available updates for the local machine.
.EXAMPLE
	PS> ./list-updates
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		Write-Host "⏳ Querying updates for installed packages..."
		& sudo apt update
		Write-Host "⏳ Querying updates for installed snaps..."
		sudo snap refresh --list
	} else {
		Write-Progress "⏳ Querying available updates..."
		" "
		& winget upgrade
		Write-Progress -Completed " "
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
