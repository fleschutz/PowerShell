<#
.SYNOPSIS
	Uninstalls Windows Terminal
.DESCRIPTION
	This PowerShell script uninstalls Windows Terminal from the local computer.
.EXAMPLE
	PS> ./uninstall-windows-terminal
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Uninstalling Windows Terminal, please wait..."

	& winget uninstall --id Microsoft.WindowsTerminal
	if ($lastExitCode -ne "0") { throw "Can't uninstall Windows Terminal, is it installed?" }

	"Windows Terminal is uninstalled now."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
