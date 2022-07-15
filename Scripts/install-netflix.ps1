<#
.SYNOPSIS
	Installs Netflix
.DESCRIPTION
	This PowerShell script installs Netflix from the Microsoft Store.
.EXAMPLE
	PS> ./install-netflix
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Installing Netflix, please wait..."

	& winget install "Netflix" --source msstore --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne "0") { throw "'winget install' failed" }

	"Netflix installed successfully."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
