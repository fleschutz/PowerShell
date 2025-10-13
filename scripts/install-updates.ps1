<#
.SYNOPSIS
	Installs software updates
.DESCRIPTION
	This PowerShell script installs software updates for the local machine (might need admin rights).
	HINT: Use the script 'list-updates.ps1' to list the latest software updates in advance.
.EXAMPLE
	PS> ./install-updates.ps1
	⏳ (1/2) Checking requirements...
	✅ Drive C: uses 56% of 1TB: 441GB free
	✅ Swap space uses 22% of 4GB: 3GB free

	⏳ (2/2) Querying Microsoft Store...
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "`n⏳ Checking requirements..." -foregroundColor green
	& "$PSScriptRoot/check-power.ps1"
	& "$PSScriptRoot/check-smart-devices.ps1"
	if ($IsLinux -or $IsMacOS) {
		& "$PSScriptRoot/check-drive-space.ps1" /
	} else {
		& "$PSScriptRoot/check-drive-space.ps1" C
	}
	& "$PSScriptRoot/check-swap-space.ps1"
	Start-Sleep -seconds 3

	if (Get-Command apt -ErrorAction SilentlyContinue) {
		Write-Host "`n⏳ Querying APT package updates..." -foregroundColor green
		& sudo apt update

		Write-Host "`n⏳ Removing obsolete packages to save space..." -foregroundColor green
		& sudo apt autoremove --yes

		Write-Host "`n⏳ Upgrading installed packages..." -foregroundColor green
		& sudo apt upgrade --yes
	}
	if (Get-Command snap -ErrorAction SilentlyContinue) {
		Write-Host "`n⏳ Upgrading installed Snaps..." -foregroundColor green
		& sudo snap refresh
	}
	if (Get-Command softwareupdate -ErrorAction SilentlyContinue) {
		Write-Host "`n⏳ Updating software..." -foregroundColor green
		& sudo softwareupdate -i -a
	}
	if (Get-Command winget -errorAction SilentlyContinue) {
		Write-Host "`n⏳ Upgrading apps from Microsoft Store..." -foregroundColor green
		& winget upgrade --all --source=msstore --include-unknown
	}
	if (Get-Command winget -errorAction SilentlyContinue) {
		Write-Host "`n⏳ Upgrading apps from WinGet..." -foregroundColor green
		& winget upgrade --all --source=winget --include-unknown
	}
	if (Get-Command choco -errorAction SilentlyContinue) {
		Write-Host "`n⏳ Upgrading by Chocolatey..." -foregroundColor green
		& choco upgrade all -y
	}
	& "$PSScriptRoot/check-pending-reboot.ps1"
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Updates installed in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
