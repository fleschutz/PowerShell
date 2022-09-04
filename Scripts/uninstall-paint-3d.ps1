<#
.SYNOPSIS
	Uninstalls Paint 3D
.DESCRIPTION
	This PowerShell script uninstalls Paint 3D from the local computer.
.EXAMPLE
	PS> ./uninstall-paint-3d
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	"Uninstalling Paint 3D, please wait..."

	& winget uninstall "Paint 3D"
	if ($lastExitCode -ne "0") { throw "Can't uninstall Paint 3D, is it installed?" }

	"Paint 3D is uninstalled now."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
