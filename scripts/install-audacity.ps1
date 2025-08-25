<#
.SYNOPSIS
	Installs Audacity
.DESCRIPTION
	This PowerShell script installs Audacity.
.EXAMPLE
	PS> ./install-audacity.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	"Installing Audacity, please wait..."

	& winget install --id Audacity.Audacity --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne 0) { throw "'winget install' failed" }

	"Audacity installed successfully."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
