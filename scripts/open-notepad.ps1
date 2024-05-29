<#
.SYNOPSIS
	Launches the Notepad app
.DESCRIPTION
	This PowerShell script launches the Notepad application.
.EXAMPLE
	PS> ./open-notepad.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Start-Process notepad.exe
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
