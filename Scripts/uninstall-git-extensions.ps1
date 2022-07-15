<#
.SYNOPSIS
	Uninstalls Git Extensions
.DESCRIPTION
	This PowerShell script uninstalls Git Extensions from the local computer.
.EXAMPLE
	PS> ./uninstall-git-extensions
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Uninstalling Git Extensions, please wait..."

	& winget uninstall --id GitExtensionsTeam.GitExtensions
	if ($lastExitCode -ne "0") { throw "Can't uninstall Git Extensions, is it installed?" }

	"Git Extensions is uninstalled now."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
