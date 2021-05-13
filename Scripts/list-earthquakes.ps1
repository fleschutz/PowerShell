<#
.SYNTAX       list-earthquakes.ps1
.DESCRIPTION  lists earthquakes with magnitude >= 6.0 for the last 30 days
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

$Format="csv" # csv, geojson, kml, text, xml
$MinMagnitude=5.8
$OrderBy="magnitude" # time, time-asc, magnitude, magnitude-asc

function ListEarthquakes { 
	write-progress "Loading data ..."
	$Earthquakes = (Invoke-WebRequest -Uri "https://earthquake.usgs.gov/fdsnws/event/1/query?format=$Format&minmagnitude=$MinMagnitude&orderby=$OrderBy" -UserAgent "curl" ).Content | ConvertFrom-CSV
	foreach ($Quake in $Earthquakes) {
		new-object PSObject -Property @{ Magnitude=$Quake.mag; Depth=$Quake.depth; Place=$Quake.place; Time=$Quake.time }
	}
}
 
try {
	ListEarthquakes | format-table -autoSize -property Magnitude,Depth,Place,Time
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
