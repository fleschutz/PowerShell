<#
.SYNOPSIS
	Uninstalls Twitter
.DESCRIPTION
	This PowerShell script uninstalls Twitter from the local computer.
.EXAMPLE
	PS> ./uninstall-twitter
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Uninstalling Twitter, please wait..."

	& winget uninstall "Twitter"
	if ($lastExitCode -ne "0") { throw "Can't uninstall Twitter, is it installed?" }

	"Twitter is uninstalled now."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
