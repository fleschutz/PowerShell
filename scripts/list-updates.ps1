<#
.SYNOPSIS
	Lists available software updates
.DESCRIPTION
	This PowerShell script queries the latest available software updates for the
	local machine and lists it (execute 'install-updates.ps1' for installation).
.EXAMPLE
	PS> ./list-updates.ps1
	⏳ Querying Microsoft Store...

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
	if (Get-Command apt -ErrorAction SilentlyContinue) {
		Write-Host "`n⏳ Querying APT package updates..." -foregroundColor green
		& sudo apt update
		& sudo apt list --upgradable
	}
	if (Get-Command snap -ErrorAction SilentlyContinue) {
		Write-Host "`n⏳ Querying Snap updates..." -foregroundColor green
		& sudo snap refresh --list
	}
	if (Get-Command brew -ErrorAction SilentlyContinue) {
		Write-Host "`n⏳ Querying Homebrew updates..." -foregroundColor green
		& brew outdated
	}
	if (Get-Command winget -ErrorAction SilentlyContinue) {
		Write-Host "`n⏳ Querying Microsoft Store..." -foregroundColor green
		& winget upgrade --include-unknown --source=msstore

		Write-Host "`n⏳ Querying WinGet..." -foregroundColor green
		& winget upgrade --include-unknown --source=winget
	}
	if (Get-Command choco -ErrorAction SilentlyContinue) {
		Write-Host "`n⏳ Querying Chocolatey..." -foregroundColor green
		& choco outdated
	}
	if (Get-Command scoop -ErrorAction SilentlyContinue) {
		Write-Host "`n⏳ Querying Scoop..." -foregroundColor green
		& scoop status
	}
	" "
	"💡 Execute 'install-updates.ps1' for installation."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
