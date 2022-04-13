<#
.SYNOPSIS
	Launches the Notepad app
.DESCRIPTION
	This script launches the Notepad application.
.EXAMPLE
	PS> ./open-note-pad
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	start-process notepad.exe
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
