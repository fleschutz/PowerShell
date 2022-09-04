<#
.SYNOPSIS
	Installs Git Extensions
.DESCRIPTION
	This PowerShell script installs Git Extensions.
.EXAMPLE
	PS> ./install-git-extensions
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Installing Git Extensions, please wait..."

	& winget install --id GitExtensionsTeam.GitExtensions --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne "0") { throw "'winget install' failed" }

	"Git Extensions installed successfully."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
