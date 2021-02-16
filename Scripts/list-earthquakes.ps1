#!/bin/powershell
<#
.SYNTAX         ./list-earthquakes.ps1
.DESCRIPTION	lists earthquakes with magnitude >= 6.0 for the last 30 days
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

$Format="csv" # csv, geojson, kml, text, xml
$MinMagnitude=6.0
$OrderBy="time" # time, time-asc, magnitude, magnitude-asc
 
try {
	write-progress "Querying earthquakes for the last 30 days ..."
	(Invoke-WebRequest -Uri "https://earthquake.usgs.gov/fdsnws/event/1/query?format=$Format&minmagnitude=$MinMagnitude&orderby=$OrderBy" -UserAgent "curl" ).Content
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
