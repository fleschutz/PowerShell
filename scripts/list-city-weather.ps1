<#
.SYNOPSIS
	Lists the weather of cities world-wide 
.DESCRIPTION
	This PowerShell script lists the current weather conditions of cities world-wide (west to east).
.EXAMPLE
	PS> ./list-city-weather.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param($cities = @("Hawaii","Los Angeles","Mexico City","Dallas","Miami","New York","Rio de Janeiro","Paris","London","Berlin","Cape Town","Dubai","Mumbai","Singapore","Hong Kong","Perth","Peking","Tokyo","Sydney"))

function ListCityWeather {
	foreach($city in $cities) {
		$Temp = (Invoke-WebRequest http://wttr.in/${City}?format="%t %c " -UserAgent "curl" -useBasicParsing).Content
		$Rain = (Invoke-WebRequest http://wttr.in/${City}?format="%p %h" -UserAgent "curl" -useBasicParsing).Content
		$Wind = (Invoke-WebRequest http://wttr.in/${City}?format="%w" -UserAgent "curl" -useBasicParsing).Content
		$Sun = (Invoke-WebRequest http://wttr.in/${City}?format="%S → %s" -UserAgent "curl" -useBasicParsing).Content
		New-Object PSObject -Property @{ CITY="$city"; TEMP="$Temp"; RAIN="$Rain"; WIND="$Wind"; SUN="$Sun" }
	}
}

try {
	ListCityWeather | Format-Table -property @{e='CITY';width=17},@{e='TEMP';width=13},@{e='RAIN';width=15},@{e='WIND';width=12},@{e='SUN';width=20}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}