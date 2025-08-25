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

#requires -version 5.1

try {
	Start-Process notepad.exe
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
