<#
.SYNOPSIS
	Installs Discord
.DESCRIPTION
	This PowerShell script installs Discord from the Microsoft Store.
.EXAMPLE
	PS> ./install-discord
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Installing Discord, please wait..."

	& winget install "Discord" --source msstore --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne "0") { throw "'winget install' failed" }

	"Discord installed successfully."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
