<#
.SYNOPSIS
	Launches Screen Sketch
.DESCRIPTION
	This script launches the Screen Sketch application.
.EXAMPLE
	PS> ./open-screen-sketch
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	start-process ms-screensketch:
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
