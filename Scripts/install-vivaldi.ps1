<#
.SYNOPSIS
	Installs Vivaldi
.DESCRIPTION
	This PowerShell script installs the Vivaldi browser.
.EXAMPLE
	PS> ./install-vivaldi
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Installing Vivaldi, please wait..."

	& winget install --id VivaldiTechnologies.Vivaldi --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne "0") { throw "'winget install' failed" }

	"Vivaldi installed successfully."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
