<#
.SYNOPSIS
	upgrade-ubuntu.ps1 
.DESCRIPTION
	Upgrades Ubuntu Linux to the latest (LTS) release.
.EXAMPLE
	PS> .\upgrade-ubuntu.ps1 
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	""
	"👉 Step 1/4: Perform a backup"
	"It's strongly recommended to perform a backup of your data BEFORE upgrading the OS!"
	$Confirm = read-host "Press <Return> to continue..."

	""
	"👉 Step 2/4: Install update-manager-core, Upgrade Packages & Reboot"
	$Confirm = read-host "Enter <yes> to perform this step (otherwise this step will be skipped)"
	if ($Confirm -eq "yes") {
		sudo apt install update-manager-core
		sudo apt update
		sudo apt list --upgradable
		sudo apt upgrade
		sudo reboot 
	}

	""
	"👉 Step 3/4: Remove obsolete kernel modules"
	$Confirm = read-host "Enter <yes> to perform this step (otherwise this step will be skipped)"
	if ($Confirm -eq "yes") {
		sudo apt --purge autoremove
	}

	""
	"👉 Step 4/4: Upgrade Ubuntu & reboot"
	$Confirm = read-host "Enter <yes> to perform this step (otherwise this step will be skipped)"
	if ($Confirm -eq "yes") {
		sudo do-release-upgrade # to latest LTS version
		#sudo do-release-upgrade -d # to latest supported release
		sudo reboot
	}

	"✔️  Done."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
