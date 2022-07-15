<#
.SYNOPSIS
	Uninstalls Visual Studio Code
.DESCRIPTION
	This PowerShell script uninstalls Visual Studio Code from the local computer.
.EXAMPLE
	PS> ./uninstall-visual-studio-code
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Uninstalling Visual Studio Code, please wait..."

	& winget uninstall "Visual Studio Code"
	if ($lastExitCode -ne "0") { throw "Can't uninstall Visual Studio Code, is it installed?" }

	"Visual Studio Code is uninstalled now."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
