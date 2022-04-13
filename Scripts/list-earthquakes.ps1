<#
.SYNOPSIS
	Lists major earthquakes since 30 days
.DESCRIPTION
	This PowerShell script lists earthquakes with magnitude >= 6.0 for the last 30 days.
.EXAMPLE
	PS> ./list-earthquakes
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

$Format="csv" # csv, geojson, kml, text, xml
$MinMagnitude=5.8
$OrderBy="magnitude" # time, time-asc, magnitude, magnitude-asc

function ListEarthquakes { 
	write-progress "Loading data ..."
	$Earthquakes = (invoke-webRequest -uri "https://earthquake.usgs.gov/fdsnws/event/1/query?format=$Format&minmagnitude=$MinMagnitude&orderby=$OrderBy" -userAgent "curl" -useBasicParsing).Content | ConvertFrom-CSV
	foreach ($Quake in $Earthquakes) {
		new-object PSObject -Property @{ Mag=$Quake.mag; Depth=$Quake.depth; Location=$Quake.place; Time=$Quake.time }
	}
}
 
try {
	ListEarthquakes | format-table -property @{e='Mag';width=5},@{e='Location';width=42},@{e='Depth';width=6},Time 
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
