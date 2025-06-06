The *cd-scripts.ps1* Script
===========================

This PowerShell script changes the working directory to the PowerShell scripts folder.

Parameters
----------
```powershell
/Repos/PowerShell/scripts/cd-scripts.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./cd-scripts.ps1
📂C:\Repos\PowerShell\scripts entered (has 645 scripts)

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
	Sets the working directory to the PowerShell scripts folder
.DESCRIPTION
	This PowerShell script changes the working directory to the PowerShell scripts folder.
.EXAMPLE
	PS> ./cd-scripts.ps1
	📂C:\Repos\PowerShell\scripts entered (has 645 scripts)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$path = Resolve-Path "$PSScriptRoot"
	if (-not(Test-Path "$path" -pathType container)) {
		throw "No PowerShell scripts folder at 📂$path"
	}
	Set-Location "$path"
	$files = Get-ChildItem $path -attributes !Directory
	"📂$path entered (has $($files.Count) scripts)"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
```

*(page generated by convert-ps2md.ps1 as of 05/12/2025 22:02:52)*
