<#
.SYNOPSIS
	Launches the Microsoft Weather app
.DESCRIPTION
	This script launches the Microsoft Weather application.
.EXAMPLE
	PS> ./open-microsoft-weather
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	start-process msnweather:
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
