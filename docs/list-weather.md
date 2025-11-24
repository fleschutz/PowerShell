The 'list-weather.ps1' Script
========================

This PowerShell script queries the 48h weather report from wttr.in and lists it in a nice table.

Parameters
----------
```powershell
PS> ./list-weather.ps1 [[-location] <String>] [<CommonParameters>]

-location <String>
    Specifies the location to use (determined automatically by default)
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./list-weather.ps1
TODAY Temp  ☂️mm  💧  💨km/h  ☀️UV  ☁️   👁km   Munich (Bayern, Germany)
 0h   🌙11°  0.0  88%   ↖ 7    1    8%    10    clear
...

```

Notes
-----
Author: Markus Fleschutz | License: CC0

Related Links
-------------
https://github.com/fleschutz/PowerShell

Script Content
--------------
```powershell
<#
.SYNOPSIS
	Lists the weather report
.DESCRIPTION
	This PowerShell script queries the 48h weather report from wttr.in and lists it in a nice table.
.PARAMETER location
	Specifies the location to use (determined automatically by default)
.EXAMPLE
	PS> ./list-weather.ps1
	TODAY Temp  ☂️mm  💧  💨km/h  ☀️UV  ☁️   👁km   Munich (Bayern, Germany)
	 0h   🌙11°  0.0  88%   ↖ 7    1    8%    10    clear
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$location = "") # empty means determine automatically

function GetEmoji([string]$text) { 
	switch ($text) {
	"Blizzard"			{ return "❄️" }
	"Blowing snow"			{ return "❄️" }
	"Clear"				{ return "🌙" }
	"Cloudy"			{ return "☁️" }
	"Fog"				{ return "🌫 " }
	"Freezing fog"			{ return "🌫 " }
	"Heavy rain"			{ return "💧" }
	"Heavy snow"			{ return "❄️" }
	"Light drizzle"			{ return "💧" }
	"Light freezing rain"		{ return "💧" }
	"Light rain"			{ return "💧" }
	"Light rain shower"		{ return "💧" }
	"Light sleet"			{ return "❄️" }
	"Light sleet showers"		{ return "❄️" }
	"Light snow"			{ return "❄️" }
	"Light snow showers"		{ return "❄️" }
	"Moderate or heavy freezing rain"{return "💧" }
	"Moderate or heavy sleet"	{ return "❄️" }
	"Moderate or heavy rain shower" { return "💧" }
	"Moderate or heavy rain in area with thunder" { return "💧" }
	"Moderate or heavy snow showers"{ return "❄️" }
	"Moderate or heavy snow in area with thunder" { return "❄️" }
	"Moderate rain"			{ return "💧" }
	"Moderate rain at times"	{ return "💧" }
	"Moderate snow"			{ return "❄️" }
	"Mist"				{ return "🌫 " }
	"Overcast"			{ return "☁️" }
	"Partly cloudy"			{ return "⛅️" }
	"Patchy heavy snow"		{ return "❄️" }
	"Patchy light drizzle"     	{ return "💧" }
	"Patchy light rain"     	{ return "💧" }
	"Patchy light rain in area with thunder" { return "💧" }
	"Patchy light rain with thunder" { return "💧" }
	"Patchy light snow"		{ return "❄️" }
	"Patchy moderate snow"		{ return "❄️" }
	"Patchy rain possible"  	{ return "💧" }
	"Patchy rain nearby"		{ return "💧" }
	"Patchy sleet nearby"		{ return "❄️" }
	"Patchy snow nearby"		{ return "❄️" }
	"Patchy snow possible"  	{ return "❄️" }
	"Sunny"				{ return "☀️" }
	"Thundery outbreaks possible"	{ return "⚡️" }
	"Thundery outbreaks in nearby"	{ return "⚡️" }
	default				{ return "?" }
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
		$temp = $(($hourly.tempC.toString()).PadLeft(2))
		$precip = $($($hourly.precipMM).PadLeft(4))
		$humidity = $(($hourly.humidity.toString()).PadLeft(3))
		$windSpeed = $(($hourly.windspeedKmph.toString()).PadLeft(2))
		$windDir = GetWindDir $hourly.winddir16Point
		$clouds = $(($hourly.cloudcover.toString()).PadLeft(3))
		$UV = $hourly.uvIndex
		$visib = $(($hourly.visibility.toString()).PadLeft(2))
		$desc = $hourly.weatherDesc.value.trim()
		$emoji = GetEmoji $desc
		if ($hour -eq 0) {
			if ($day -eq 0) {
				Write-Host "`nTODAY  Temp  ☂️mm    💧 💨km/h   ☁️  ☀️UV 👁 km  $area ($region, $country)" -foregroundColor green
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
		"$(($hour.toString()).PadLeft(2))h   $($emoji)$temp°  $precip  $humidity%   $($windDir)$windSpeed   $clouds%   $UV   $visib   $desc"
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
```

*(page generated by convert-ps2md.ps1 as of 11/24/2025 20:40:22)*
