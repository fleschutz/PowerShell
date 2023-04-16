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
		"⏳ (1/4) Querying updates for installed Debian packages..."
		& sudo apt update
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