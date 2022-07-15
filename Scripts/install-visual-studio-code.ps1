<#
.SYNOPSIS
	Installs Visual Studio Code
.DESCRIPTION
	This PowerShell script installs Visual Studio Code.
.EXAMPLE
	PS> ./install-visual-studio-code
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Installing Visual Studio Code, please wait..."

	& winget install --id Microsoft.VisualStudioCode --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne "0") { throw "'winget install' failed" }

	"Visual Studio Code installed successfully."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
