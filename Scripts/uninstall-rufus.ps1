<#
.SYNOPSIS
	Uninstalls Rufus
.DESCRIPTION
	This PowerShell script uninstalls Rufus from the local computer.
.EXAMPLE
	PS> ./uninstall-rufus
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Uninstalling Rufus, please wait..."

	& winget uninstall "Rufus"
	if ($lastExitCode -ne "0") { throw "Can't uninstall Rufus, is it installed?" }

	"Rufus is uninstalled now."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
