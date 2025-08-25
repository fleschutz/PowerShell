<#
.SYNOPSIS
	Lists details of all countries
.DESCRIPTION
	This PowerShell script lists details of all countries.
.EXAMPLE
	PS> ./list-countries.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function ListCountries { 
	$Countries = (Invoke-WebRequest -uri "https://restcountries.eu/rest/v2/all" -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json
	foreach($Country in $Countries) {
		New-Object PSObject -Property @{
			'Country' = "$($Country.Name)"
			'Capital' = "$($Country.Capital)"
			'Population' = "$($Country.Population)"
			'TLD' = "$($Country.TopLevelDomain)"
			'Phone' = "+$($Country.CallingCodes)"
		}
	}
}

try {
	ListCountries | format-table -property Country,Capital,Population,TLD,Phone
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
