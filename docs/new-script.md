The *new-script.ps1* Script
===========================

This PowerShell script creates a new PowerShell script file by using the template file ../data/template.ps1.

Parameters
----------
```powershell
/Repos/PowerShell/scripts/new-script.ps1 [[-filename] <String>] [<CommonParameters>]

-filename <String>
    Specifies the path and filename to the new script
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./new-script myscript.ps1
✅ Created the new 'myscript.ps1' PowerShell script in 1 sec

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
	Creates a new PowerShell script
.DESCRIPTION
	This PowerShell script creates a new PowerShell script file by using the template file ../data/template.ps1.
.PARAMETER filename
	Specifies the path and filename to the new script
.EXAMPLE
	PS> ./new-script myscript.ps1
	✅ Created the new 'myscript.ps1' PowerShell script in 1 sec
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$filename = "")

try {
	if ($filename -eq "" ) { $filename = Read-Host "Enter the new filename" }
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	Copy-Item "$PSScriptRoot/../data/template.ps1" "$filename"

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Created the new '$filename' PowerShell script in $elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(page generated by convert-ps2md.ps1 as of 01/23/2025 12:15:23)*
