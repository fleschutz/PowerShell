<#
.SYNOPSIS
	Ping the currrent weather conditions
.DESCRIPTION
	This PowerShell script continuously shows the current weather conditions (similar to htop, 10 min update interval by default).
.PARAMETER Location
	Specifies the location to use (determined automatically per default)
.EXAMPLE
	PS> ./ping-weather Paris
	Sunny  🌡23°C  ☂️0.0mm  💨9km/h from S  ☁️0%  💧41%  ☀️UV6  1020hPa  🕗10:24 AM UTC  @Paris (Ile-de-France)...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$Location = "", [int]$UpdateInterval = 600000)

try {
	do {
		$Weather = (Invoke-WebRequest -URI http://wttr.in/${Location}?format=j1 -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json
		$Description = $Weather.current_condition.WeatherDesc.value
		$TempC = $Weather.current_condition.temp_C
		$PrecipMM = $Weather.current_condition.precipMM
		$WindSpeed = $Weather.current_condition.windspeedKmph
		$WindDir = $Weather.current_condition.winddir16Point
		$Clouds = $Weather.current_condition.cloudcover
		$Humidity = $Weather.current_condition.humidity
		$UV = $Weather.current_condition.uvIndex
		$Visib = $Weather.current_condition.visibility 
		$Pressure = $Weather.current_condition.pressure
		$Time = $Weather.current_condition.observation_time
	        $Area = $Weather.nearest_area.areaName.value
	        $Region = $Weather.nearest_area.region.value
		"$Description  🌡$($TempC)°C  ☂️$($PrecipMM)mm  💨$($WindSpeed)km/h from $WindDir  ☁️$($Clouds)%  💧$($Humidity)%  ☀️UV$UV  👀$($Visib)km  $($Pressure)hPa  🕗$Time UTC  @$Area ($Region)..."
		start-sleep -milliseconds $UpdateInterval
	} while ($true)
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}