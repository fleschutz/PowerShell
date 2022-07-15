<#
.SYNOPSIS
	Uninstalls Netflix
.DESCRIPTION
	This PowerShell script uninstalls Netflix from the local computer.
.EXAMPLE
	PS> ./uninstall-netflix
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Uninstalling Netflix, please wait..."

	& winget uninstall "Netflix"
	if ($lastExitCode -ne "0") { throw "Can't uninstall Netflix, is it installed?" }

	"Netflix is uninstalled now."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
