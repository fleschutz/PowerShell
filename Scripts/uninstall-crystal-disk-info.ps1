<#
.SYNOPSIS
	Uninstalls CrystalDiskInfo
.DESCRIPTION
	This PowerShell script uninstalls CrystalDiskInfo from the local computer.
.EXAMPLE
	PS> ./uninstall-crystal-disk-info
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Uninstalling CrystalDiskInfo, please wait..."

	& winget uninstall "CrystalDiskInfo"
	if ($lastExitCode -ne "0") { throw "Can't uninstall CrystalDiskInfo, is it installed?" }

	"CrystalDiskInfo is uninstalled now."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
