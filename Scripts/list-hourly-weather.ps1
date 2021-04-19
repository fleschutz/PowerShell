#!/usr/bin/pwsh
<#
.SYNTAX       list-hourly-weather.ps1 [<location>]
.DESCRIPTION  lists the hourly weather today
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Location = "") # empty means determine automatically

try {
	$Weather = (Invoke-WebRequest http://wttr.in/${Location}?format=j1 -UserAgent "curl" ).Content | ConvertFrom-Json

	$Area = $Weather.nearest_area.areaName.value
	$Region = $Weather.nearest_area.region.value
	$Country = $Weather.nearest_area.country.value
	"🕗 Hourly weather today at $Area ($Region, $Country)"

	[int]$Hour = 0
	foreach ($Hourly in $Weather.weather.hourly) {
		$Temp = $Hourly.tempC
		$Precip = $Hourly.precipMM
		$Humidity = $Hourly.humidity
		$Pressure = $Hourly.pressure
		$WindSpeed = $Hourly.windspeedKmph
		$WindDir = $Hourly.winddir16Point
		$UV = $Hourly.uvIndex
		$Visib = $Hourly.visibility
		$Clouds = $Hourly.cloudcover
		$Desc = $Hourly.weatherDesc.value
		"$($Hour):00: $($Temp)°C $($Precip)mm $($Humidity)% $($Pressure)hPa $WindDir $($WindSpeed)km/h UV$($UV) $($Visib)km $($Clouds)% ($Desc)"
		$Hour++
	}

	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
