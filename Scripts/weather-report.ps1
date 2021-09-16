<#
.SYNOPSIS
	weather-report.ps1 [<geo-location>]
.DESCRIPTION
	Prints the local weather report.
.EXAMPLE
	PS> .\weather-report.ps1 Paris
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$GeoLocation = "") # empty means determine automatically

try {
	(invoke-webRequest http://v2d.wttr.in/$GeoLocation -UserAgent "curl" ).Content
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
