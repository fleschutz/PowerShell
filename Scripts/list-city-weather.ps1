<#
.SYNOPSIS
	list-city-weather.ps1
.DESCRIPTION
	List the current weather of cities world-wide (west to east).
.EXAMPLE
	PS> .\list-city-weather.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Cities="Hawaii","Los Angeles","Mexico City","Miami","New York","Rio de Janeiro","Paris","London","Berlin","Cape Town","Dubai","Mumbai","Singapore","Hong Kong","Peking","Tokyo","Sydney"

try {
	foreach($City in $Cities) {
		$Line = (Invoke-WebRequest http://wttr.in/${City}?format="%c %l+%t+%p+%h+%P+%w +%S →+%s" -UserAgent "curl").Content
		"$Line"
	}
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
