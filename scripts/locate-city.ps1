<#
.SYNOPSIS
	Shows the geographic location of a city
.DESCRIPTION
	This PowerShell script shows the geographic location of the given city.
.PARAMETER city
	Specifies the name of the city (ask the user if not given)
.EXAMPLE
	PS> ./locate-city.ps1 Amsterdam
	📍Amsterdam in New York (United States) with population 21241 is at 42.9420°N, -74.1907°W.
	📍Amsterdam in Noord-Holland (Netherlands) with population 1031000 is at 52.3500°N, 4.9166°W.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$city = "")

try {
	if ($city -eq "" ) { $city = Read-Host "Enter the name of the city" }

	Write-Progress "Reading data/worldcities.csv..."
	$table = Import-CSV "$PSScriptRoot/data/worldcities.csv"
	$foundOne = $false
	foreach($row in $table) {
		if ($row.city -eq $city) {
			$foundOne = $true
			$country = $row.country
			$region = $row.admin_name
			$lat = $row.lat
			$lng = $row.lng
			if ($lat -lt 0.0) { $latText = "$(-$lat)°S" } else { $latText = "$lat°N" }
			if ($lng -lt 0.0) { $lngText = "$(-$lng)°E" } else { $lngText = "$lng°W" }
			$population = $row.population
			"📍$city in $region ($country) with population $population is at $latText, $lngText."
		}
	}
	if (-not $foundOne) { throw "There's no city '$city' in the database" }
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
