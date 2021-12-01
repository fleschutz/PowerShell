<#
.SYNOPSIS
	Checks the weather 
.DESCRIPTION
	Checks the current weather for critical values.
.PARAMETER location
	Specifies the location to use (determined automatically per default)
.EXAMPLE
	PS> ./check-weather
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

param([string]$location = "") # empty means determine automatically

function Check { param([int]$Value, [int]$NormalMin,  [int]$NormalMax, [string]$Unit)  
	if ($Value -lt $NormalMin) {
		return "$Value $Unit ! "
	}
	if ($Value -gt $NormalMax) {
		return "$Value $Unit ! "
	}
	return ""
}

try {
	$Weather = (Invoke-WebRequest http://wttr.in/${location}?format=j1 -UserAgent "curl" ).Content | ConvertFrom-Json

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
	"Now: $($Temp)°C  $($Precip)mm  $($Humidity)%  $($WindSpeed)km/h from $WindDir  $($Pressure)hPa  UV$($UV)  $($Visib)km  $($Clouds)%  $Desc  at $Area ($Region)"

	$Result+=Check $Weather.current_condition.windspeedKmph 0 48 "km/h"
	$Result+=Check $Weather.current_condition.visibility 1 1000 "km visibility"
	$Result+=Check $Weather.current_condition.temp_C -20 40 "°C"
	$Result+=Check $Weather.current_condition.uvIndex 0 6 "UV"

	if ($Result -eq "") {
		"Calm weather"
	} else {
		"WEATHER ALERT: $Result"
	}
	$Reply = "$($Temp)°C, $($Precip)mm rain, $($Humidity)% humidity, $($Clouds)% clouds with wind $($WindSpeed)km/h from $WindDir at $Area ($Region)"
	"✔️ $Reply"
	& "$PSScriptRoot/speak-english.ps1" "$Reply"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
