<#
.SYNOPSIS
	Installs Spotify
.DESCRIPTION
	This PowerShell script installs Spotify from the Microsoft Store.
.EXAMPLE
	PS> ./install-spotify
.LINK
	https://github.com/fleschutz/talk2windows
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Installing Spotify, please wait..."

	& winget install "Spotify - Music and Podcasts" --source msstore --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne "0") { throw "'winget install' failed" }

	"Spotify installed successfully."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
