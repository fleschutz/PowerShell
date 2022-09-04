<#
.SYNOPSIS
	Uninstalls Discord
.DESCRIPTION
	This PowerShell script uninstalls Discord from the local computer.
.EXAMPLE
	PS> ./uninstall-discord
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Uninstalling Discord, please wait..."

	& winget uninstall "Discord"
	if ($lastExitCode -ne "0") { throw "Can't uninstall Discord, is it installed?" }

	"Discord is uninstalled now."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
