<#
.SYNOPSIS
	Lists details of all countries
.DESCRIPTION
	This script lists details of all countries.
.EXAMPLE
	PS> ./list-countries
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
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
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
