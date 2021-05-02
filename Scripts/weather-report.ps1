<#
.SYNTAX       weather-report.ps1 [<geo-location>]
.DESCRIPTION  prints the local weather report 
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($GeoLocation = "") # empty means determine automatically

try {
	(invoke-webRequest http://v2d.wttr.in/$GeoLocation -UserAgent "curl" ).Content
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
