<#
.SYNOPSIS
	Installs VLC
.DESCRIPTION
	This PowerShell script installs the VLC media player.
.EXAMPLE
	PS> ./install-vlc
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Installing VLC media player, please wait..."

	& winget install --id VideoLAN.VLC --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne "0") { throw "'winget install' failed" }

	"VLC media player installed successfully."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
