#!/snap/bin/powershell

# Syntax:	./latlong.ps1 <city>
# Description:	prints the Lat/Long of the given city
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$City)
 
try {
	$Table = import-csv worldcities.csv
	$FoundOne = 0
	foreach($Row in $Table) {
		if ($Row.city -eq $City) {
			$FoundOne = 1
			$Country = $Row.country
			$Region = $Row.admin_name
			$Lat = $Row.lat
			$Long = $Row.lng
			$Population = $Row.population
			write-host "✔️ $City ($Country, $Region, $Population people) is at N$Lat° / W$Long°"
		}
	}

	if ($FoundOne) {
		exit 0
	}
	write-error "City $City not found"
	exit 1
} catch { write-error $Error[0] }
exit 1
