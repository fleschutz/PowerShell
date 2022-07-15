<#
.SYNOPSIS
	Uninstalls Spotify
.DESCRIPTION
	This PowerShell script uninstalls Spotify from the local computer.
.EXAMPLE
	PS> ./uninstall-spotify
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Uninstalling Spotify, please wait..."

	& winget uninstall "Spotify - Music and Podcasts"
	if ($lastExitCode -ne "0") { throw "Can't uninstall Spotify, is it installed?" }

	"Spotify is uninstalled now."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
