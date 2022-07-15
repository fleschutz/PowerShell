<#
.SYNOPSIS
	Installs Zoom
.DESCRIPTION
	This PowerShell script installs Zoom.
.EXAMPLE
	PS> ./install-zoom
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Installing Zoom, please wait..."

	& winget install --id Zoom.Zoom --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne "0") { throw "'winget install' failed" }

	"Zoom installed successfully."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
