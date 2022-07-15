<#
.SYNOPSIS
	Installs Opera Browser
.DESCRIPTION
	This PowerShell script installs Opera Browser from Microsoft Store.
.EXAMPLE
	PS> ./install-opera-browser
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Installing Opera Browser, please wait..."

	& winget install "Opera Browser" --source msstore --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne "0") { throw "'winget install' failed" }

	"Opera Browser installed successfully."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
