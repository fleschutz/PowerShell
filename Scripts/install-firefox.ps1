<#
.SYNOPSIS
	Installs Mozilla Firefox
.DESCRIPTION
	This PowerShell script installs Mozilla Firefox from the Microsoft Store.
.EXAMPLE
	PS> ./install-firefox
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Installing Firefox, please wait..."

	& winget install "Mozilla Firefox Browser" --source msstore --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne "0") { throw "'winget install' failed" }

	"Firefox installed successfully."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
