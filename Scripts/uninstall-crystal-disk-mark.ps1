<#
.SYNOPSIS
	Uninstalls CrystalDiskMark
.DESCRIPTION
	This PowerShell script uninstalls CrystalDiskMark from the local computer.
.EXAMPLE
	PS> ./uninstall-crystal-disk-mark
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Uninstalling CrystalDiskMark, please wait..."

	& winget uninstall "CrystalDiskMark Shizuku Edition"
	if ($lastExitCode -ne "0") { throw "Can't uninstall CrystalDiskMark, is it installed?" }

	"CrystalDiskMark is uninstalled now."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
