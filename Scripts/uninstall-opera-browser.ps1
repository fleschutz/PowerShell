<#
.SYNOPSIS
	Uninstalls Opera Browser
.DESCRIPTION
	This PowerShell script uninstalls Opera Browser from the local computer.
.EXAMPLE
	PS> ./uninstall-opera-browser
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Uninstalling Opera Browser, please wait..."

	& winget uninstall "Opera Browser"
	if ($lastExitCode -ne "0") { throw "Can't uninstall Opera Browser, is it installed?" }

	"Opera Browser is uninstalled now."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
