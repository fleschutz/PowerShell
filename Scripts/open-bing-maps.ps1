<#
.SYNOPSIS
	Launches the Bing Maps app
.DESCRIPTION
	This script launches the Bing Maps application.
.EXAMPLE
	PS> ./open-bing-maps
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	start-process bingmaps:
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
