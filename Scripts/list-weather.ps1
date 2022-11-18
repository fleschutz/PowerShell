<#
.SYNOPSIS
	Lists the weather report
.DESCRIPTION
	This PowerShell script lists the hourly weather report.
.PARAMETER Location
	Specifies the location to use (determined automatically per default)
.EXAMPLE
	PS> ./list-weather
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$Location = "") # empty means determine automatically

function Describe { param([string]$Desc)
	switch($Desc) {
	"Clear"				{ return "🌙 clear       " }
	"Cloudy"			{ return "☁️ cloudy      " }
	"Light drizzle"			{ return "💧 light drizzle" }
	"Light rain"			{ return "💧 light rain   " }
	"Light rain shower"		{ return "💧 light rain shower" }
	"Mist"				{ return "🌫  misty      " }
	"Overcast"			{ return "☁️ overcast    " }
	"Partly cloudy"			{ return "⛅️partly cloudy" }
	"Patchy light rain"     	{ return "💧 patchy light rain" }
	"Patchy rain possible"  	{ return "💧 patchy rain possible" }
	"Sunny"				{ return "☀️ sunny       " }
	"Thundery outbreaks possible"	{ return "⚡️thundery outbreaks possible" }
	default				{ return "$Desc" }
	}
}

try {
	$Weather = (Invoke-WebRequest -URI http://wttr.in/${Location}?format=j1 -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json
	$Area = $Weather.nearest_area.areaName.value
	$Region = $Weather.nearest_area.region.value
	$Country = $Weather.nearest_area.country.value	
	[int]$Day = 0
	foreach($Hourly in $Weather.weather.hourly) {
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
				Write-Host -foregroundColor green "Today  🌡°C   ☂️mm   💧   💨km/h from  ☀️UV   ☁️    at $Area ($Region, $Country)"
			} elseif ($Day -eq 1) {
				Write-Host -foregroundColor green "Tomorrow"
			} else {
				Write-Host -foregroundColor green "Day after tomorrow"
			}
			$Day++
		}
		"$(($Hour.toString()).PadLeft(2))°°   $(($Temp.toString()).PadLeft(2))°   $($Precip)   $(($Humidity.toString()).PadLeft(3))%      $(($WindSpeed.toString()).PadLeft(2)) $WindDir`t$($UV)   $(($Clouds.toString()).PadLeft(3))%   $(Describe $Desc)"
		$Hour++
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}