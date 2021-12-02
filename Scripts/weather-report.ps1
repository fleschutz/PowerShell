<#
.SYNOPSIS
	Lists the local weather report
.DESCRIPTION
	This script lists the local weather report.
.PARAMETER GeoLocation
	Specifies the geographic location to use (determine automatically by default)
.EXAMPLE
	PS> ./weather-report Paris
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$GeoLocation = "") # empty means determine automatically

try {
	(invoke-webRequest http://v2d.wttr.in/$GeoLocation -userAgent "curl" -useBasicParsing).Content
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
