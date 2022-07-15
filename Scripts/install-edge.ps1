<#
.SYNOPSIS
	Installs Microsoft Edge
.DESCRIPTION
	This PowerShell script installs the Microsoft Edge Browser from the Microsoft Store.
.EXAMPLE
	PS> ./install-edge
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Installing Edge, please wait..."

	& winget install "Microsoft Edge Browser" --source msstore --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne "0") { throw "'winget install' failed" }

	"Microsoft Edge installed successfully."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
