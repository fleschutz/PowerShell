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
	Author: Markus Fleschutz / License: CC0
#>

try {
	""
	"👉 Step 1/4: Perform a backup"
	"It's strongly recommended to backup your data BEFORE the upgrade!"
	$Confirm = read-host "Press <Return> to continue..."

	""
	"👉 Step 2/4: Install update-manager-core, Upgrade Packages & Reboot"
	$Confirm = read-host "Enter <yes> to perform this step (otherwise it will be skipped)"
	if ($Confirm -eq "yes") {
		sudo apt install update-manager-core
		sudo apt update
		sudo apt list --upgradable
		sudo apt upgrade
		sudo reboot 
	}

	""
	"👉 Step 3/4: Remove obsolete kernel modules"
	$Confirm = read-host "Enter <yes> to perform this step (otherwise it will be skipped)"
	if ($Confirm -eq "yes") {
		sudo apt --purge autoremove
	}

	""
	"👉 Step 4/4: Upgrade Ubuntu & reboot"
	$Confirm = read-host "Enter <LTS> to upgrade to latest LTS release, <latest> to upgrade to latest Ubuntu release (otherwise this step will be skipped)"
	if ($Confirm -eq "LTS") {
		sudo do-release-upgrade
		sudo reboot
	} elseif ($Confirm -eq "latest") {
		sudo do-release-upgrade -d
		sudo reboot
	}

	"✔️  Done."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
