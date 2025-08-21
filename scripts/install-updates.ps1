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

	"`n⏳ Checking requirements..."
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
		"`n⏳ Querying latest package information..."
		& sudo apt update

		"`n⏳ Removing obsolete packages to save space..."
		& sudo apt autoremove --yes

		"`n⏳ Upgrading installed packages..."
		& sudo apt upgrade --yes
	}
	if (Get-Command snap -ErrorAction SilentlyContinue) {
		"`n⏳ Upgrading installed Snaps..."
		& sudo snap refresh
	}
	if (Get-Command softwareupdate -ErrorAction SilentlyContinue) {
		"`n⏳ Installing updates..."
		& sudo softwareupdate -i -a
	}
	if (Get-Command winget -errorAction SilentlyContinue) {
		"`n⏳ Querying Microsoft Store..."
		& winget upgrade --all --source=msstore --include-unknown
	}
	if (Get-Command winget -errorAction SilentlyContinue) {
		"`n⏳ Querying WinGet..."
		& winget upgrade --all --source=winget --include-unknown
	}
	if (Get-Command choco -errorAction SilentlyContinue) {
		"`n⏳ Querying Chocolatey..."
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
