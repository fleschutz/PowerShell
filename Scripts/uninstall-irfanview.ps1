<#
.SYNOPSIS
	Uninstalls IrfanView
.DESCRIPTION
	This PowerShell script uninstalls IrfanView from the local computer.
.EXAMPLE
	PS> ./uninstall-irfanview
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Uninstalling IrfanView, please wait..."

	& winget uninstall "IrfanView64"
	if ($lastExitCode -ne "0") { throw "Can't uninstall IrfanView, is it installed?" }

	"IrfanView is uninstalled now."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
