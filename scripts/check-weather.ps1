<#
.SYNOPSIS
	Checks the weather 
.DESCRIPTION
	This PowerShell script checks the current weather report.
.PARAMETER location
	Specifies the location to use (determined automatically per default)
.EXAMPLE
	PS> ./check-weather.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$location = "") # empty means determine automatically

try {
	$Weather = (Invoke-WebRequest http://wttr.in/${location}?format=j1 -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json

	$Temp = $Weather.current_condition.temp_C
	$Precip = $Weather.current_condition.precipMM
	$Humidity = $Weather.current_condition.humidity
	$Pressure = $Weather.current_condition.pressure
	$WindSpeed = $Weather.current_condition.windspeedKmph
	$WindDir = $Weather.current_condition.winddir16Point
	$UV = $Weather.current_condition.uvIndex
	$Visib = $Weather.current_condition.visibility
	$Clouds = $Weather.current_condition.cloudcover
	$Desc = $Weather.current_condition.weatherDesc.value
	$Area = $Weather.nearest_area.areaName.value
	$Region = $Weather.nearest_area.region.value

	& "$PSScriptRoot/speak-english.ps1" "$($Temp)°C, $($Precip)mm rain, $($Humidity)% humidity, $($WindSpeed)km/h wind from $WindDir with $($Clouds)% clouds and $($Visib)km visibility at $Area ($Region)."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
