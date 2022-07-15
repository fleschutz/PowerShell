<#
.SYNOPSIS
	Uninstalls Skype
.DESCRIPTION
	This PowerShell script uninstalls Skype from the local computer.
.EXAMPLE
	PS> ./uninstall-skype
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	"Uninstalling Skype, please wait..."

	& winget uninstall "Skype"
	if ($lastExitCode -ne "0") { throw "Can't uninstall Skype, is it installed?" }

	"Skype is uninstalled now."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
