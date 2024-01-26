<#
.SYNOPSIS
	Lists the weather report
.DESCRIPTION
	This PowerShell script lists the hourly weather report in a nice table.
.PARAMETER Location
	Specifies the location to use (determined automatically per default)
.EXAMPLE
	PS> ./list-weather.ps1
	TODAY   🌡°C  ☂️mm  💧  💨km/h ☀️UV  ☁️  👁km  at Munich (Bayern, Germany)
	 0°°   -2°   0.0   93%   ↗ 6   1    21%  10  🌙 clear
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$Location = "") # empty means determine automatically

function GetDescription { param([string]$text)
	switch ($text.trim()) {
	"Blizzard"			{ return "❄️ blizzard ⚠️" }
	"Blowing snow"			{ return "❄️ blowing snow ⚠️" }
	"Clear"				{ return "🌙 clear" }
	"Cloudy"			{ return "☁️ cloudy" }
	"Fog"				{ return "🌫  fog" }
	"Freezing fog"			{ return "🌫  freezing fog" }
	"Heavy snow"			{ return "❄️ heavy snow ⚠️" }
	"Light drizzle"			{ return "💧 light drizzle" }
	"Light freezing rain"		{ return "💧 light freezing rain ⚠️" }
	"Light rain"			{ return "💧 light rain" }
	"Light rain shower"		{ return "💧 light rain shower" }
	"Light sleet"			{ return "❄️ light sleet" }
	"Light sleet showers"		{ return "❄️ light sleet showers" }
	"Light snow"			{ return "❄️ light snow" }
	"Light snow showers"		{ return "❄️ light snow showers" }
	"Moderate or heavy freezing rain"{return "💧 moderate or heavy freezing rain ⚠️" }
	"Moderate or heavy sleet"	{ return "❄️ moderate or heavy sleet ⚠️" }
	"Moderate or heavy rain shower" { return "💧 moderate or heavy rain shower ⚠️" }
	"Moderate or heavy snow showers"{ return "❄️ moderate or heavy snow showers ⚠️" }
	"Moderate rain"			{ return "💧 moderate rain" }
	"Moderate rain at times"	{ return "💧 moderate rain at times" }
	"Moderate snow"			{ return "❄️ moderate snow" }
	"Mist"				{ return "🌫  misty" }
	"Overcast"			{ return "☁️ overcast" }
	"Partly cloudy"			{ return "⛅️partly cloudy" }
	"Patchy heavy snow"		{ return "❄️ patchy heavy snow ⚠️" }
	"Patchy light drizzle"     	{ return "💧 patchy light drizzle" }
	"Patchy light rain"     	{ return "💧 patchy light rain" }
	"Patchy light rain with thunder" { return "💧 patchy light rain with thunder" }
	"Patchy light snow"		{ return "❄️ patchy light snow" }
	"Patchy moderate snow"		{ return "❄️ patchy moderate snow" }
	"Patchy rain possible"  	{ return "💧 patchy rain possible" }
	"Patchy rain nearby"		{ return "💧 patchy rain nearby" }
	"Patchy snow possible"  	{ return "❄️ patchy snow possible" }
	"Sunny"				{ return "☀️ sunny" }
	"Thundery outbreaks possible"	{ return "⚡️thundery outbreaks possible" }
	default				{ return "$Text" }
	}
}

function GetWindDir { param([string]$Text)
	switch($Text) {
	"NW"	{ return "↘" }
	"NNW"	{ return "↓" }
	"N"	{ return "↓" }
	"NNE"	{ return "↓" }
	"NE"	{ return "↙" }
	"ENE"	{ return "←" }
	"E"	{ return "←" }
	"ESE"	{ return "←" }
	"SE"	{ return "↖" }
	"SSE"	{ return "↑" }
	"S"	{ return "↑" }
	"SSW"	{ return "↑" }
	"SW"	{ return "↗" }
	"WSW"	{ return "→" }
	"W"	{ return "→" }
	"WNW"	{ return "→" }
	default { return "$Text" }
	}
}

try {
	Write-Progress "Loading weather data from http://wttr.in ..."
	$Weather = (Invoke-WebRequest -URI http://wttr.in/${Location}?format=j1 -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json
	Write-Progress -completed "."
	$Area = $Weather.nearest_area.areaName.value
	$Region = $Weather.nearest_area.region.value
	$Country = $Weather.nearest_area.country.value	
	[int]$Day = 0
	foreach($Hourly in $Weather.weather.hourly) {
		$Hour = $Hourly.time / 100
		$Temp = $(($Hourly.tempC.toString()).PadLeft(3))
		$Precip = $Hourly.precipMM
		$Humidity = $(($Hourly.humidity.toString()).PadLeft(3))
		$Pressure = $Hourly.pressure
		$WindSpeed = $(($Hourly.windspeedKmph.toString()).PadLeft(2))
		$WindDir = GetWindDir $Hourly.winddir16Point
		$UV = $Hourly.uvIndex
		$Clouds = $(($Hourly.cloudcover.toString()).PadLeft(3))
		$Visib = $(($Hourly.visibility.toString()).PadLeft(2))
		$Desc = GetDescription $Hourly.weatherDesc.value
		if ($Hour -eq 0) {
			if ($Day -eq 0) {
				Write-Host -foregroundColor green "TODAY   🌡°C  ☂️mm  💧  💨km/h  ☀️UV  ☁️   👁km   at $Area ($Region, $Country)"
			} elseif ($Day -eq 1) {
				$Date = (Get-Date).AddDays(1)
				[string]$Weekday = $Date.DayOfWeek
				Write-Host -foregroundColor green "$($Weekday.toUpper())"
			} else {
				$Date = (Get-Date).AddDays(2)
				[string]$Weekday = $Date.DayOfWeek
				Write-Host -foregroundColor green "$($Weekday.toUpper())"
			}
			$Day++
		}
		"$(($Hour.toString()).PadLeft(2))°°  $Temp°   $Precip  $Humidity%   $($WindDir)$WindSpeed    $UV   $Clouds%   $Visib   $Desc"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
