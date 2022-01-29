<#
.SYNOPSIS
	Launches the Clock app
.DESCRIPTION
	This PowerShell script launches the Clock application.
.EXAMPLE
	PS> ./open-clock
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	start-process ms-clock:
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
