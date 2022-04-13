<#
.SYNOPSIS
	Lists the hourly weather report
.DESCRIPTION
	This PowerShell script lists the hourly weather report.
.PARAMETER Location
	Specifies the location to use (determined automatically per default)
.EXAMPLE
	PS> ./list-weather
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$Location = "") # empty means determine automatically

try {
	$Weather = (invoke-webRequest -uri http://wttr.in/${Location}?format=j1 -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json

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
		$Clouds = $Hourly.cloudcover
		$Desc = $Hourly.weatherDesc.value
		if ($Hour -eq 0) {
			if ($Day -eq 0) {
				write-host -foregroundColor green "🕗      🌡°C   ☂️    💧     💨 from     ☀️UV ☁️    TODAY at $Area ($Region, $Country)"
			} elseif ($Day -eq 1) {
				write-host -foregroundColor green "                                                  TOMORROW"
			} else {
				write-host -foregroundColor green "                                                  DAY AFTER TOMORROW"
			}
			$Day++
		}
		"$(($Hour.toString()).PadLeft(2))°°   $(($Temp.toString()).PadLeft(2))°   $($Precip)mm $(($Humidity.toString()).PadLeft(3))%   $(($WindSpeed.toString()).PadLeft(2))km/h $WindDir`t$($UV)  $(($Clouds.toString()).PadLeft(3))%   $Desc"
		$Hour++
	}

	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
