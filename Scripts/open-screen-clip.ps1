<#
.SYNOPSIS
	Launches Screen Clip
.DESCRIPTION
	This script launches the Screen Clip application.
.EXAMPLE
	PS> ./open-screen-clip
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	start-process ms-screenclip:
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
