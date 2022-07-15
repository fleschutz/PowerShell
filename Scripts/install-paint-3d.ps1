<#
.SYNOPSIS
	Installs Paint 3D
.DESCRIPTION
	This PowerShell script installs Paint 3D from the Microsoft Store.
.EXAMPLE
	PS> ./install-paint-3d
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Installing Paint 3D, please wait..."

	& winget install "Paint 3D" --source msstore --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne "0") { throw "'winget install' failed" }

	"Paint 3D installed successfully."
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
