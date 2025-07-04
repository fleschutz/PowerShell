The *new-text-file.ps1* Script
===========================

This PowerShell script creates a new .txt file from: ../data/templates/New.txt.

Parameters
----------
```powershell
/Repos/PowerShell/scripts/new-text-file.ps1 [[-path] <String>] [<CommonParameters>]

-path <String>
    Specifies the path and new filename (README.txt by default)
    
    Required?                    false
    Position?                    1
    Default value                README.txt
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
PS> ./new-text-file.ps1 
✅ New 'README.txt' created (from data/templates/New.txt).

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
	Creates a text file 
.DESCRIPTION
	This PowerShell script creates a new .txt file from: ../data/templates/New.txt.
.PARAMETER path
	Specifies the path and new filename (README.txt by default)
.EXAMPLE
	PS> ./new-text-file.ps1 
	✅ New 'README.txt' created (from data/templates/New.txt).
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "README.txt")

try {
	if (Test-Path "$path" -pathType leaf) { throw "File '$path' is already existing" }

	$pathToTemplate = Resolve-Path "$PSScriptRoot/../data/templates/New.txt" 
	Copy-Item $pathToTemplate "$path"
	if ($lastExitCode -ne 0) { throw "Can't copy template to: $path" }

	"✅ New '$path' created (from data/templates/New.txt)."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
```

*(page generated by convert-ps2md.ps1 as of 06/22/2025 10:37:39)*
