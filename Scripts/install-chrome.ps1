<#
.SYNOPSIS
	Installs Chrome
.DESCRIPTION
	This PowerShell script installs the Google Chrome browser.
.EXAMPLE
	PS> ./install-chrome
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Installing Google Chrome, please wait..."

	& winget install --id Google.Chrome --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne "0") { throw "'winget install' failed" }

	"Google Chrome installed successfully."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
