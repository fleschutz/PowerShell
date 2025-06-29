The *weather-report.ps1* Script
===========================

This PowerShell script lists the local weather report.

Parameters
----------
```powershell
/Repos/PowerShell/scripts/weather-report.ps1 [[-GeoLocation] <String>] [<CommonParameters>]

-GeoLocation <String>
    Specifies the geographic location to use (determine automatically by default)
    
    Required?                    false
    Position?                    1
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
PS> ./weather-report Paris

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
	Lists the local weather report
.DESCRIPTION
	This PowerShell script lists the local weather report.
.PARAMETER GeoLocation
	Specifies the geographic location to use (determine automatically by default)
.EXAMPLE
	PS> ./weather-report Paris
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$GeoLocation = "") # empty means determine automatically

try {
	(Invoke-WebRequest http://v2d.wttr.in/$GeoLocation -userAgent "curl" -useBasicParsing).Content
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(page generated by convert-ps2md.ps1 as of 06/22/2025 10:37:42)*
