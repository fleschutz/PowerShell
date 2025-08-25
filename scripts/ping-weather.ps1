<#
.SYNOPSIS
	Ping the currrent weather conditions
.DESCRIPTION
	This PowerShell script continuously shows the current weather conditions (similar to htop, 10 min update interval by default).
.PARAMETER Location
	Specifies the location to use (determined automatically per default)
.EXAMPLE
	PS> ./ping-weather
	Current weather conditions at Paris (Ile-de-France), updating every 10 min...
	🕗10:24 AM UTC  🌡23°C  ☂️0.0mm  💨9km/h from S  ☁️0%  💧41%  ☀️UV6  1020hPa  Sunny
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$Location = "", [int]$UpdateInterval = 600)

try {
	$Weather = (Invoke-WebRequest -URI http://wttr.in/${Location}?format=j1 -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json
        $Area = $Weather.nearest_area.areaName.value
        $Region = $Weather.nearest_area.region.value
	"Current weather conditions at $Area ($Region), updating every $($UpdateInterval / 60) min..."
	do {
		
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

		"🕗$Time UTC  🌡$($TempC)°C  ☂️$($PrecipMM)mm  💨$($WindSpeed)km/h from $WindDir  ☁️$($Clouds)%  💧$($Humidity)%  ☀️UV$UV  👀$($Visib)km  $($Pressure)hPa  $Description"
		Start-Sleep -s $UpdateInterval
		$Weather = (Invoke-WebRequest -URI http://wttr.in/${Location}?format=j1 -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json
	} while ($true)
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
