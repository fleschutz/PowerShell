<#
.SYNOPSIS
	Lists the local weather report
.DESCRIPTION
	This PowerShell script lists the local weather report.
.PARAMETER GeoLocation
	Specifies the geographic location to use (determine automatically by default)
.EXAMPLE
	PS> ./weather-report Paris
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$GeoLocation = "") # empty means determine automatically

try {
	(Invoke-WebRequest http://v2d.wttr.in/$GeoLocation -userAgent "curl" -useBasicParsing).Content
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
