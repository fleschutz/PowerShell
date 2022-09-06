<#
.SYNOPSIS
	Launches Screen Clip
.DESCRIPTION
	This script launches the Screen Clip application.
.EXAMPLE
	PS> ./open-screen-clip
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Start-Process ms-screenclip:
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
