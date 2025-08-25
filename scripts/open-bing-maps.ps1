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
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	Start-Process bingmaps:
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
