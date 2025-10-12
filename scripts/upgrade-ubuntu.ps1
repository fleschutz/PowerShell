<#
.SYNOPSIS
	Upgrades Ubuntu Linux 
.DESCRIPTION
	This PowerShell script upgrades Ubuntu Linux to the latest (LTS) release.
.EXAMPLE
	PS> .\upgrade-ubuntu.ps1 
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"⏳ (1/4) Checking requirements..."
	& "$PSScriptRoot/check-power.ps1"
	& "$PSScriptRoot/check-smart-devices.ps1"
	if ($IsLinux -or $IsMacOS) {
		& "$PSScriptRoot/check-drive-space.ps1" /
	} else {
		& "$PSScriptRoot/check-drive-space.ps1" C
	}
	& "$PSScriptRoot/check-swap-space.ps1"
	"NOTE: It's strongly recommended to backup your data BEFORE the upgrade!"
	$confirm = Read-Host "Press <Return> to continue..."
	""
	"⏳ (2/4) Upgrade installed packages, then reboot"
	$confirm = Read-Host "Enter <yes> to perform this step (otherwise it will be skipped)"
	if ($confirm -eq "yes") {
		sudo apt install update-manager-core
		"⏳ Updating..."
		sudo apt update
		sudo apt list --upgradable
		"⏳ Upgrading..."
		sudo apt upgrade
		"⏳ Rebooting..."
		sudo reboot 
	}
	""
	"⏳ (3/4) Remove obsolete kernel modules"
	$confirm = Read-Host "Enter <yes> to perform this step (otherwise it will be skipped)"
	if ($confirm -eq "yes") {
		sudo apt --purge autoremove
	}
	""
	"⏳ (4/4) Upgrade Ubuntu OS, then reboot"
	$confirm = Read-Host "Enter <LTS> to upgrade to latest LTS release, <latest> to upgrade to latest Ubuntu release (otherwise this step will be skipped)"
	if ($confirm -eq "LTS") {
		sudo do-release-upgrade
		"⏳ Rebooting..."
		sudo reboot
	} elseif ($confirm -eq "latest") {
		sudo do-release-upgrade -d
		"⏳ Rebooting..."
		sudo reboot
	}
	"✅ Update done."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
