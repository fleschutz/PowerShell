<#
.SYNOPSIS
	Launches the Remote Desktop app
.DESCRIPTION
	This script launches the Remote Desktop application.
.EXAMPLE
	PS> ./open-remote-desktop
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	start-process ms-rd:
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
