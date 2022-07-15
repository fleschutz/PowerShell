<#
.SYNOPSIS
	Uninstalls VLC
.DESCRIPTION
	This PowerShell script uninstalls the VLC media player from the local computer.
.EXAMPLE
	PS> ./uninstall-vlc
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Uninstalling VLC media player, please wait..."

	& winget uninstall "VLC"
	if ($lastExitCode -ne "0") { throw "Can't uninstall VLC media player, is it installed?" }

	"VLC media player is uninstalled now."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
