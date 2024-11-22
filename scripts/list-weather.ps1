<#
.SYNOPSIS
	Lists the weather report
.DESCRIPTION
	This PowerShell script queries the 48h weather report from wttr.in and lists it in a nice table.
.PARAMETER location
	Specifies the location to use (determined automatically by default)
.EXAMPLE
	PS> ./list-weather.ps1
	TODAY  🌡°C  ☂️mm  💧  💨km/h  ☀️UV  ☁️   👁km   at Munich (Bayern, Germany)
	 0h   11°   0.0   88%   ↖ 7    1    8%    10   🌙 clear
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$location = "") # empty means determine automatically

function GetDescription([string]$text) { 
	switch ($text) {
	"Blizzard"			{ return "❄️ blizzard ⚠️" }
	"Blowing snow"			{ return "❄️ blowing snow ⚠️" }
	"Clear"				{ return "🌙 clear" }
	"Cloudy"			{ return "☁️ cloudy" }
	"Fog"				{ return "🌫  fog" }
	"Freezing fog"			{ return "🌫  freezing fog" }
	"Heavy rain"			{ return "💧 heavy rain ⚠️" }
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
	"Moderate or heavy rain in area with thunder" { return "💧 moderate or heavy rain in area with thunder ⚠️" }
	"Moderate or heavy snow showers"{ return "❄️ moderate or heavy snow showers ⚠️" }
	"Moderate or heavy snow in area with thunder" { return "❄️ moderate or heavy snow in area with thunder ⚠️" }
	"Moderate rain"			{ return "💧 moderate rain" }
	"Moderate rain at times"	{ return "💧 moderate rain at times" }
	"Moderate snow"			{ return "❄️ moderate snow" }
	"Mist"				{ return "🌫  misty" }
	"Overcast"			{ return "☁️ overcast" }
	"Partly cloudy"			{ return "⛅️partly cloudy" }
	"Patchy heavy snow"		{ return "❄️ patchy heavy snow ⚠️" }
	"Patchy light drizzle"     	{ return "💧 patchy light drizzle" }
	"Patchy light rain"     	{ return "💧 patchy light rain" }
	"Patchy light rain in area with thunder" { return "💧 patchy light rain in area with thunder" }
	"Patchy light rain with thunder" { return "💧 patchy light rain with thunder" }
	"Patchy light snow"		{ return "❄️ patchy light snow" }
	"Patchy moderate snow"		{ return "❄️ patchy moderate snow" }
	"Patchy rain possible"  	{ return "💧 patchy rain possible" }
	"Patchy rain nearby"		{ return "💧 patchy rain nearby" }
	"Patchy sleet nearby"		{ return "❄️ patchy sleet nearby" }
	"Patchy snow nearby"		{ return "❄️ patchy snow nearby" }
	"Patchy snow possible"  	{ return "❄️ patchy snow possible" }
	"Sunny"				{ return "☀️ sunny" }
	"Thundery outbreaks possible"	{ return "⚡️thundery outbreaks possible" }
	"Thundery outbreaks in nearby"	{ return "⚡️thundery outbreaks in nearby" }
	default				{ return $text }
	}
}

function GetWindDir([string]$text) {
	switch($text) {
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
	default { return "$text" }
	}
}

try {
	Write-Progress "Loading weather data from http://wttr.in ..."
	$weather = (Invoke-WebRequest -URI http://wttr.in/${location}?format=j1 -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json
	$area = $weather.nearest_area.areaName.value
	$region = $weather.nearest_area.region.value
	$country = $weather.nearest_area.country.value
	Write-Progress -completed "Done."
	
	[int]$day = 0
	foreach($hourly in $weather.weather.hourly) {
		$hour = $hourly.time / 100
		$tempC = $(($hourly.tempC.toString()).PadLeft(3))
		$precip = $($($hourly.precipMM).PadLeft(4))
		$humidity = $(($hourly.humidity.toString()).PadLeft(3))
		$pressure = $hourly.pressure
		$windSpeed = $(($hourly.windspeedKmph.toString()).PadLeft(2))
		$windDir = GetWindDir $hourly.winddir16Point
		$UV = $hourly.uvIndex
		$clouds = $(($hourly.cloudcover.toString()).PadLeft(3))
		$visib = $(($hourly.visibility.toString()).PadLeft(2))
		$desc = GetDescription $hourly.weatherDesc.value.trim()
		if ($hour -eq 0) {
			if ($day -eq 0) {
				Write-Host "TODAY  🌡°C  ☂️mm   💧  💨km/h ☀️UV   ☁️   👁km   at $area ($region, $country)" -foregroundColor green
			} elseif ($day -eq 1) {
				$date = (Get-Date).AddDays(1)
				[string]$dayOfWeek = $date.DayOfWeek
				Write-Host "$($dayOfWeek.toUpper())" -foregroundColor green
			} else {
				$date = (Get-Date).AddDays(2)
				[string]$dayOfWeek = $date.DayOfWeek
				Write-Host "$($dayOfWeek.toUpper())" -foregroundColor green
			}
			$day++
		}
		"$(($hour.toString()).PadLeft(2))h  $tempC°   $precip  $humidity%   $($windDir)$windSpeed    $UV   $clouds%   $visib   $desc"
	}
	exit 0 # success
} catch {
	"⚠️ Sorry: $($Error[0]) in script line $($_.InvocationInfo.ScriptLineNumber)."
	exit 1
}
