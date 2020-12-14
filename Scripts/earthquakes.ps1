#!/snap/bin/powershell

# Syntax:	./earthquakes.ps1
# Description:	prints the stronger earthquakes for the last 30 days
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

$Format="csv" # csv, geojson, kml, text, xml
$MinMagnitude=6.0
$OrderBy="time" # time, time-asc, magnitude, magnitude-asc
 
try {
	Write-Progress "Querying earthquakes for the last 30 days ..."
	(Invoke-WebRequest -Uri "https://earthquake.usgs.gov/fdsnws/event/1/query?format=$Format&minmagnitude=$MinMagnitude&orderby=$OrderBy" -UserAgent "curl" ).Content
	exit 0
} catch {
	Write-Error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
