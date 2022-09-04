<#
.SYNOPSIS
	Uninstalls Mozilla Firefox
.DESCRIPTION
	This PowerShell script uninstalls Mozilla Firefox from the local computer.
.EXAMPLE
	PS> ./uninstall-firefox
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Uninstalling Mozilla Firefox, please wait..."

	& winget uninstall "Mozilla Firefox"
	if ($lastExitCode -ne "0") { throw "Can't uninstall Firefox, is it installed?" }

	"Mozilla Firefox is uninstalled now."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
