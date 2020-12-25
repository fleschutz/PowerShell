#!/snap/bin/powershell

# Syntax:	./list-earthquakes.ps1
# Description:	lists earthquakes >= 6.0 for the last 30 days
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

$Format="csv" # csv, geojson, kml, text, xml
$MinMagnitude=6.0
$OrderBy="time" # time, time-asc, magnitude, magnitude-asc
 
try {
	write-progress "Querying earthquakes for the last 30 days ..."
	(Invoke-WebRequest -Uri "https://earthquake.usgs.gov/fdsnws/event/1/query?format=$Format&minmagnitude=$MinMagnitude&orderby=$OrderBy" -UserAgent "curl" ).Content
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
