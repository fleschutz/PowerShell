<#
.SYNOPSIS
	Launches the Bing Maps app
.DESCRIPTION
	This PowerShell script launches the Bing Maps application.
.EXAMPLE
	PS> ./open-bing-maps
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	start-process bingmaps:
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
