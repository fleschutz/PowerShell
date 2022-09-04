<#
.SYNOPSIS
	Installs IrfanView
.DESCRIPTION
	This PowerShell script installs IrfanView from the Microsoft Store.
.EXAMPLE
	PS> ./install-irfan-view
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Installing IrfanView, please wait..."

	& winget install "IrfanView64" --source msstore --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne "0") { throw "'winget install' failed" }

	"IrfanView installed successfully."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
