#!/snap/bin/powershell

# Syntax:	./locate-zip-code.ps1 [<country-code>] [<zip-code>]
# Description:	prints the geographic location of the given zip-code
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$CountryCode, [string]$ZipCode)
if ($CountryCode -eq "" ) {
	$CountryCode = read-host "Enter the country code"
}
if ($ZipCode -eq "" ) {
	$ZipCode = read-host "Enter the zip code"
}
$PathToDataDir=(get-item $MyInvocation.MyCommand.Path).directory
$PathToDataDir="$PathToDataDir/../Data"
 
try {
	write-progress "Reading zip-codes.csv..."
	$Table = import-csv "$PathToDataDir/zip-codes.csv"

	$FoundOne = 0
	foreach($Row in $Table) {
		if ($Row.country -eq $CountryCode) {
			if ($Row.postal_code -eq $ZipCode) {
				$Country=$Row.country
				$City = $Row.city
				$Lat = $Row.latitude
				$Lon = $Row.longitude
				write-host "* $Country $ZipCode $City is at $Lat°N, $Lon°W"
				$FoundOne = 1
			}
		}
	}

	if ($FoundOne) {
		exit 0
	}
	write-error "Zip-code $ZipCode in country $CountryCode not found"
	exit 1
} catch {
	Write-Error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
