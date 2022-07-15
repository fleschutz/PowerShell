c<#
.SYNOPSIS
	Uninstalls One Calendar
.DESCRIPTION
	This PowerShell script uninstalls One Calendar from the local computer.
.EXAMPLE
	PS> ./uninstall-one-calendar
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Uninstalling One Calendar, please wait..."

	& winget uninstall "One Calendar"
	if ($lastExitCode -ne "0") { throw "Can't uninstall One Calendar, is it installed?" }

	"One Calendar is uninstalled now."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
