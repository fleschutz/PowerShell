<#
.SYNOPSIS
	Launch the Magnifier
.DESCRIPTION
	This script launches the Windows Screen Magnifier application.
.EXAMPLE
	PS> ./open-magnifier.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	Start-Process magnify.exe
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
