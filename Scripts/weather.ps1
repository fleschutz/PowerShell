<#
.SYNOPSIS
	weather.ps1 [<geo-location>]
.DESCRIPTION
	Prints the current weather forecast
.EXAMPLE
	PS> .\weather.ps1 Paris
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

param([string]$GeoLocation = "") # empty means determine automatically

try {
	(invoke-webRequest http://wttr.in/$GeoLocation -UserAgent "curl" ).Content
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
