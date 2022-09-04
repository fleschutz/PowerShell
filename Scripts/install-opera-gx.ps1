<#
.SYNOPSIS
	Installs Opera GX
.DESCRIPTION
	This PowerShell script installs Opera GX from Microsoft Store.
.EXAMPLE
	PS> ./install-opera-gx
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Installing Opera GX, please wait..."

	& winget install "Opera GX" --source msstore --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne "0") { throw "'winget install' failed" }

	"Opera GX installed successfully."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
