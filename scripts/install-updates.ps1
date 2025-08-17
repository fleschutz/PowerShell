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

	if ($IsLinux) {
		"⏳ (1/5) Checking requirements..."
		& "$PSScriptRoot/check-power.ps1"
		& "$PSScriptRoot/check-smart-devices.ps1"
		& "$PSScriptRoot/check-drive-space.ps1" /
		& "$PSScriptRoot/check-swap-space.ps1"
		Start-Sleep -seconds 3
		""
		"⏳ (2/5) Querying latest package information..."
		& sudo apt update

		"⏳ (3/5) Removing obsolete packages (to save disk space)..."
		& sudo apt autoremove --yes

		"⏳ (4/5) Upgrading installed packages..."
		& sudo apt upgrade --yes

		"⏳ (5/5) Upgrading installed Snaps..."
		& sudo snap refresh
	} elseif ($IsMacOS) {
		Write-Progress "⏳ Installing updates..."
		& sudo softwareupdate -i -a
		Write-Progress -completed " "
	} else { # Windows:
		"⏳ (1/2) Checking requirements..."
		& "$PSScriptRoot/check-power.ps1"
		& "$PSScriptRoot/check-smart-devices.ps1"
		& "$PSScriptRoot/check-drive-space.ps1" C
		& "$PSScriptRoot/check-swap-space.ps1"
		Start-Sleep -seconds 3
		""
		"⏳ (2/4) Querying Microsoft Store..."
		if (Get-Command winget -errorAction SilentlyContinue) {
			& winget upgrade --all --source=msstore --include-unknown
		}
		""
		"⏳ (3/4) Querying WinGet..."
		if (Get-Command winget -errorAction SilentlyContinue) {
			& winget upgrade --all --source=winget --include-unknown
		}
		""
		"⏳ (4/4) Querying Chocolatey..."
		if (Get-Command choco -errorAction SilentlyContinue) {
			& choco upgrade all -y
		}
	}
	& "$PSScriptRoot/check-pending-reboot.ps1"
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Updates installed in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
