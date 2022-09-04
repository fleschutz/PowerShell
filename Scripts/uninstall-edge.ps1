<#
.SYNOPSIS
	Uninstalls Microsoft Edge
.DESCRIPTION
	This PowerShell script uninstalls Microsoft Edge from the local computer.
.EXAMPLE
	PS> ./uninstall-edge
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Uninstalling Microsoft Edge, please wait..."

	& winget uninstall "Microsoft Edge Browser"
	if ($lastExitCode -ne "0") { throw "Can't uninstall Edge, is it installed?" }

	"Microsoft Edge is uninstalled now."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
