<#
.SYNOPSIS
	Lists current weather of cities world-wide 
.DESCRIPTION
	This PowerShell script lists the current weather of cities world-wide (west to east).
.EXAMPLE
	PS> ./list-city-weather
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

$Cities="Hawaii","Los Angeles","Mexico City","Dallas","Miami","New York","Rio de Janeiro","Paris","London","Berlin","Cape Town","Dubai","Mumbai","Singapore","Hong Kong","Perth","Peking","Tokyo","Sydney"

function ListCityWeather {
	foreach($City in $Cities) {
		$Conditions = (Invoke-WebRequest http://wttr.in/${City}?format="%c  +%t`t+%p`t+%h`t+%P  +%w" -UserAgent "curl" -useBasicParsing).Content
		$Sun = (Invoke-WebRequest http://wttr.in/${City}?format="+%S →+%s" -UserAgent "curl" -useBasicParsing).Content
		New-Object PSObject -Property @{ City="$City"; Conditions="$Conditions"; Sun="$Sun" }
	}
}

try {
	ListCityWeather | Format-Table -property City,Conditions,Sun
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
