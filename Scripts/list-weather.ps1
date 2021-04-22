<#
.SYNTAX       list-weather.ps1 [<location>]
.DESCRIPTION  lists the hourly weather 
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Location = "") # empty means determine automatically

try {
	$Weather = (Invoke-WebRequest http://wttr.in/${Location}?format=j1 -UserAgent "curl" ).Content | ConvertFrom-Json

	$Area = $Weather.nearest_area.areaName.value
	$Region = $Weather.nearest_area.region.value
	$Country = $Weather.nearest_area.country.value	

	[int]$Day = 0
	foreach ($Hourly in $Weather.weather.hourly) {
		$Hour = $Hourly.time / 100
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
		if ($Hour -eq 0) {
			if ($Day -eq 0) {
				"🕗 Today at $Area ($Region, $Country)"
			} elseif ($Day -eq 1) {
				"🕗 Tomorrow"
			} else {
				"🕗 Day After Tomorrow"
			}
			$Day++
		}
		"$($Hour)°°`t$($Temp)°C`t$($Precip)mm $($Humidity)%`t$($WindSpeed)km/h from $WindDir`t$($Pressure)hPa  UV$($UV)  $($Visib)km  $($Clouds)%  $Desc"
		$Hour++
	}

	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
