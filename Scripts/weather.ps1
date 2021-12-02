<#
.SYNOPSIS
	Lists the current weather forecast
.DESCRIPTION
	This script lists the current weather forecast.
.PARAMETER GeoLocation
	Specifies the geographic location to use
.EXAMPLE
	PS> ./weather Paris
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$GeoLocation = "") # empty means determine automatically

try {
	(Invoke-WebRequest http://wttr.in/$GeoLocation -userAgent "curl" -useBasicParsing).Content
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
