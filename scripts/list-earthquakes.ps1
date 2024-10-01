<#
.SYNOPSIS
	Lists major earthquakes
.DESCRIPTION
	This PowerShell script lists major earthquakes for the last 30 days.
.PARAMETER minMagnitude
	Specifies the minimum magnitude to list (5.5 by default)
.EXAMPLE
	PS> ./list-earthquakes.ps1

	Mag   Location                                   Depth        Time UTC
	---   --------                                   -----        --------
	7.2   98 km S of Sand Point, Alaska              33 km        2023-07-16T06:48:22.606Z
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([float]$minMagnitude=5.5)

$Format="csv" # cap, csv, geojson, kml, kmlraw, quakeml, text, xml
$OrderBy="magnitude" # time, time-asc, magnitude, magnitude-asc

function ListEarthquakes { 
	Write-Progress "Loading data from earthquake.usgs.gov..."
	$quakes = (Invoke-WebRequest -URI "https://earthquake.usgs.gov/fdsnws/event/1/query?format=$Format&minmagnitude=$minMagnitude&orderby=$OrderBy" -userAgent "curl" -useBasicParsing).Content | ConvertFrom-CSV
	Write-Progress -completed "done."

	foreach($quake in $quakes) {
		[int]$depth = $quake.depth
		New-Object PSObject -Property @{ Mag=$quake.mag; Depth="$depth km"; Location=$quake.place; 'Time UTC'=$quake.time }
	}

}
 
try {
	ListEarthquakes | Format-Table -property @{e='Mag';width=5},@{e='Location';width=42},@{e='Depth';width=12},'Time UTC' 
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
