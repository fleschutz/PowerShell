<#
.SYNOPSIS
	Launches the Paint 3D app
.DESCRIPTION
	This script launches the Paint 3D application.
.EXAMPLE
	PS> ./open-paint-3d
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	start-process ms-paint:
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
