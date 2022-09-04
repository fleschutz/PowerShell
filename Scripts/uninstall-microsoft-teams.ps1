<#
.SYNOPSIS
	Uninstalls Microsoft Teams
.DESCRIPTION
	This PowerShell script uninstalls Microsoft Teams from the local computer.
.EXAMPLE
	PS> ./uninstall-microsoft-teams
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Uninstalling Microsoft Teams, please wait..."

	& winget uninstall --id Microsoft.Teams
	if ($lastExitCode -ne "0") { throw "Can't uninstall Microsoft Teams, is it installed?" }

	"Microsoft Teams is uninstalled now."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
