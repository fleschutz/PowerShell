<#
.SYNOPSIS
	weather.ps1 [<geo-location>]
.DESCRIPTION
	Prints the current weather forecast.
.EXAMPLE
	PS> .\weather.ps1 Paris
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$GeoLocation = "") # empty means determine automatically

try {
	(invoke-webRequest http://wttr.in/$GeoLocation -UserAgent "curl" ).Content
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
