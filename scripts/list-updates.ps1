<#
.SYNOPSIS
	Lists software updates
.DESCRIPTION
	This PowerShell script queries the latest available software updates for the
	local machine and lists it.
	NOTE: Execute 'install-updates.ps1' to install the listed updates.
.EXAMPLE
	PS> ./list-updates.ps1
	⏳ Querying updates from Microsoft Store...

	Name               Id                    Version       Available
	----------------------------------------------------------------
	Git                Git.Git               2.43.0        2.44.0   
        ...
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
	} elseif ($IsMacOS) {
		throw "Sorry, MacOS not supported yet"
	} else {
		if (Get-Command winget -ErrorAction SilentlyContinue) {
			Write-Host "`n⏳ Querying updates from Microsoft Store..." -foregroundColor green
			& winget upgrade --include-unknown --source=msstore

			Write-Host "`n⏳ Querying updates from WinGet Store..." -foregroundColor green
			& winget upgrade --include-unknown --source=winget
		}
		if (Get-Command choco -ErrorAction SilentlyContinue) {
			Write-Host "`n⏳ Querying updates from Chocolatey..." -foregroundColor green
			& choco outdated
		}
	}
	" "
	"💡 Execute 'install-updates.ps1' to install the listed updates."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
