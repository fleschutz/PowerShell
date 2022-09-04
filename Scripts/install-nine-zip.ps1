<#
.SYNOPSIS
	Installs 9 ZIP
.DESCRIPTION
	This PowerShell script installs 9 ZIP from the Microsoft Store.
.EXAMPLE
	PS> ./install-nine-zip
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Installing 9 Zip, please wait..."

	& winget install "9 ZIP - open rar, zip, 7zip, gzip" --source msstore --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne "0") { throw "'winget install' failed" }

	"9 Zip installed successfuly."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
