<#
.SYNOPSIS
	Installs Mozilla Firefox
.DESCRIPTION
	This PowerShell script installs Mozilla Firefox from the Microsoft Store.
.EXAMPLE
	PS> ./install-firefox.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Installing Mozilla Firefox, please wait..."

	& winget install "Mozilla Firefox Browser" --source msstore --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne "0") { throw "'winget install' failed" }

	"Mozilla Firefox installed successfully."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
