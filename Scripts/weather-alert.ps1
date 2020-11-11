#!/snap/bin/powershell

# Syntax:	./weather-alert.ps1
# Description:	checks the current weather for critical values
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
 
$GeoLocation="" # empty means determine automatically

function Check {
	param ([int]$Value, [int]$Min,  [int]$Max, [string]$Unit)  
	if ($Value -lt $Min) {
		return "$Value $Unit !"
	}
	if ($Value -gt $Max) {
		return "$Value $Unit !"
	}
	return ""
}

try {
	$Weather=(Invoke-WebRequest http://wttr.in/${GeoLocation}?format=j1 -UserAgent "curl" ).Content | ConvertFrom-Json

	$Result+=Check $Weather.current_condition.windspeedKmph 0 48 "km/h"
	$Result+=Check $Weather.current_condition.temp_C -20 35 "°C"
	$Result+=Check $Weather.current_condition.uvIndex 0 10 "UV"

	if ($Result -eq "") {
		echo "Calm weather"
	} else {
		echo "WEATHER ALERT: $Result"
	}
	exit 0
} catch { Write-Error $Error[0] }
exit 1
