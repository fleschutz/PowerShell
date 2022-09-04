<#
.SYNOPSIS
	Installs Skype
.DESCRIPTION
	This PowerShell script installs Skype from the Microsoft Store.
.EXAMPLE
	PS> ./install-skype
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Installing Skype, please wait..."

	& winget install "Skype" --source msstore --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne "0") { throw "'winget install' failed" }

	"Skype installed successfully."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
