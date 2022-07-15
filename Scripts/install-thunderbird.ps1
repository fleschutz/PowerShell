<#
.SYNOPSIS
	Installs Thunderbird
.DESCRIPTION
	This PowerShell script installs Mozilla Thunderbird.
.EXAMPLE
	PS> ./install-thunderbird
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Installing Mozilla Thunderbird, please wait..."

	& winget install --id Mozilla.Thunderbird --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne "0") { throw "'winget install' failed" }

	"Mozilla Thunderbird installed successfully."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
