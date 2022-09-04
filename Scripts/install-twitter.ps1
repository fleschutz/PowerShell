<#
.SYNOPSIS
	Installs Twitter
.DESCRIPTION
	This PowerShell script installs Twitter from the Microsoft Store.
.EXAMPLE
	PS> ./install-twitter
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Installing Twitter, please wait..."

	& winget install "Twitter" --source msstore --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne "0") { throw "'winget install' failed" }

	"Twitter installed successfully."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
