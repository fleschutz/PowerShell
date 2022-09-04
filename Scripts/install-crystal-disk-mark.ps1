<#
.SYNOPSIS
	Installs CrystalDiskMark
.DESCRIPTION
	This PowerShell script installs CrystalDiskMark from the Microsoft Store.
.EXAMPLE
	PS> ./install-crystal-disk-mark
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Installing CrystalDiskMark, please wait..."

	& winget install "CrystalDiskMark Shizuku Edition" --source msstore --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne "0") { throw "'winget install' failed" }

	"CrystalDiskMark installed successfully."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
