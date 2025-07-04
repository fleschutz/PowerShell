The *locate-zip-code.ps1* Script
===========================

This PowerShell script prints the geographic location of the given zip-code.

Parameters
----------
```powershell
/Repos/PowerShell/scripts/locate-zip-code.ps1 [[-CountryCode] <String>] [[-ZipCode] <String>] [<CommonParameters>]

-CountryCode <String>
    Specifies the country code
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

-ZipCode <String>
    Specifies the zip code
    
    Required?                    false
    Position?                    2
    Default value                
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./locate-zip-code.ps1 de 87600
* DE 87600 Kaufbeuren is at 47.8824°N, 10.6219°W

```

Notes
-----
Author: Markus Fleschutz | License: CC0

Related Links
-------------
https://github.com/fleschutz/PowerShell

Script Content
--------------
```powershell
<#
.SYNOPSIS
	Prints the geo location of a zip-code
.DESCRIPTION
	This PowerShell script prints the geographic location of the given zip-code.
.PARAMETER CountryCode
	Specifies the country code
.PARAMETER ZipCode
	Specifies the zip code
.EXAMPLE
	PS> ./locate-zip-code.ps1 de 87600
	* DE 87600 Kaufbeuren is at 47.8824°N, 10.6219°W
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$CountryCode = "", [string]$ZipCode = "")

try {
	if ($CountryCode -eq "" ) { $CountryCode = read-host "Enter the country code" }
	if ($ZipCode -eq "" ) { $ZipCode = read-host "Enter the zip code" }

	write-progress "Reading zip-codes.csv..."
	$Table = import-csv "$PSScriptRoot/../data/zip-codes.csv"

	$FoundOne = 0
	foreach($Row in $Table) {
		if ($Row.country -eq $CountryCode) {
			if ($Row.postal_code -eq $ZipCode) {
				$Country=$Row.country
				$City = $Row.city
				$Lat = $Row.latitude
				$Lon = $Row.longitude
				write-output "* $Country $ZipCode $City is at $Lat°N, $Lon°W"
				$FoundOne = 1
			}
		}
	}

	if ($FoundOne) {
		exit 0 # success
	}
	throw "Zip-code $ZipCode in country $CountryCode not found"
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(page generated by convert-ps2md.ps1 as of 06/22/2025 10:37:38)*
