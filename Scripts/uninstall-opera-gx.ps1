<#
.SYNOPSIS
	Uninstalls Opera GX
.DESCRIPTION
	This PowerShell script uninstalls Opera GX from the local computer.
.EXAMPLE
	PS> ./uninstall-opera-gx
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	"Uninstalling Opera GX, please wait..."

	& winget uninstall "Opera GX"
	if ($lastExitCode -ne "0") { throw "Can't uninstall Opera Browser, is it installed?" }

	"Opera GX is uninstalled now."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
