<#
.SYNOPSIS
	Writes the current location 
.DESCRIPTION
	This PowerShell script determines the location and writes it to the console.
.EXAMPLE
	PS> ./write-location.ps1
	📍47.7278°,10.3192° near 87435 Kempten in Bavaria, Germany.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$location = (Invoke-WebRequest -URI http://ifconfig.co/json  -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json
	$lat = $location.latitude
	$long = $location.longitude
	$city = $location.city
	$zip = $location.zip_code
	$region = $location.region_name
	$country = $location.country
	Write-Output "📍$lat°,$long° near $zip $city in $region, $country."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
