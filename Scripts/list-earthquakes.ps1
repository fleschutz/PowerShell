<#
.SYNOPSIS
	Lists major earthquakes
.DESCRIPTION
	This PowerShell script lists major earthquakes with magnitude >= 6.0 for the last 30 days.
.EXAMPLE
	PS> ./list-earthquakes.ps1

	Mag   Location                                   Depth        Time
	---   --------                                   -----        ----
	7.2   98 km S of Sand Point, Alaska              33 km        2023-07-16T06:48:22.606Z
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

$Format="csv" # cap, csv, geojson, kml, kmlraw, quakeml, text, xml
$MinMagnitude=5.7
$OrderBy="magnitude" # time, time-asc, magnitude, magnitude-asc

function ListEarthquakes { 
	Write-Progress "Loading data from earthquake.usgs.gov..."
	$Quakes = (Invoke-WebRequest -URI "https://earthquake.usgs.gov/fdsnws/event/1/query?format=$Format&minmagnitude=$MinMagnitude&orderby=$OrderBy" -userAgent "curl" -useBasicParsing).Content | ConvertFrom-CSV
	foreach ($Quake in $Quakes) {
		[int]$Depth = $Quake.depth
		New-Object PSObject -Property @{ Mag=$Quake.mag; Depth="$Depth km"; Location=$Quake.place; Time=$Quake.time }
	}
	Write-Progress -completed "Loading finished."
}
 
try {
	ListEarthquakes | Format-Table -property @{e='Mag';width=5},@{e='Location';width=42},@{e='Depth';width=12},Time 
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
