<#
.SYNOPSIS
	Prints the geographic location of a city
.DESCRIPTION
	This PowerShell script prints the geographic location of the given city.
.PARAMETER city
	Specifies the name of the city to look for
.EXAMPLE
	PS> ./locate-city.ps1 Amsterdam
	* Amsterdam (United States, New York, population 21241) is at 42.9420°N, -74.1907°W
	* Amsterdam (Netherlands, Noord-Holland, population 1031000) is at 52.3500°N, 4.9166°W
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$city = "")

try {
	if ($city -eq "" ) { $city = Read-Host "Enter the name of the city" }

	Write-Progress "Reading data/worldcities.csv..."
	$table = Import-CSV "$PSScriptRoot/../data/worldcities.csv"

	$foundOne = 0
	foreach($row in $table) {
		if ($row.city -eq $city) {
			$foundOne = 1
			$country = $row.country
			$region = $row.admin_name
			$lat = $row.lat
			$long = $row.lng
			$population = $row.population
			Write-Host "* $city ($country, $region, population $population) is at $lat°N, $long°W"
		}
	}
	if (-not $foundOne) { throw "No city '$city' found in database" }
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
