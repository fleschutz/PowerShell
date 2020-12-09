#!/snap/bin/powershell

# Syntax:	./latlong.ps1 [<city>]
# Description:	prints the lat/long coordinates of the given city
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$City)
if ($City -eq "" ) {
	$City = read-host "Enter the city"
}
 
try {
	write-progress "Reading worldcities.csv..."
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
			write-host "* $City ($Country, $Region, population $Population) is at $Lat°N, $Long°W"
		}
	}

	if ($FoundOne) {
		exit 0
	}
	write-error "City $City not found"
	exit 1
} catch {
	Write-Error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
