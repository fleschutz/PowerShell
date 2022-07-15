<#
.SYNOPSIS
	Installs Windows Terminal
.DESCRIPTION
	This PowerShell script installs Windows Terminal from the Microsoft Store.
.EXAMPLE
	PS> ./install-windows-terminal
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Installing Windows Terminal, please wait..."

	& winget install --id Microsoft.WindowsTerminal --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne "0") { throw "'winget install' failed" }

	"Windows Terminal installed successfully."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
