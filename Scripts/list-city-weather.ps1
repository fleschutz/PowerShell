<#
.SYNOPSIS
	List the current weather of cities world-wide 
.DESCRIPTION
	List the current weather of cities world-wide (west to east)
	list-city-weather.ps1
.EXAMPLE
	PS> ./list-city-weather
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
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
