The *check-ps1-file.ps1* Script
===========================

This PowerShell script checks the given PowerShell script file(s) for validity.

Parameters
----------
```powershell
/Repos/PowerShell/scripts/check-ps1-file.ps1 [[-filePattern] <String>] [<CommonParameters>]

-filePattern <String>
    Specifies the file pattern to the PowerShell file(s)
    
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
PS> ./check-ps1-file *.ps1
✅ Valid PowerShell in myfile.ps1

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
	Checks PowerShell file(s) for validity
.DESCRIPTION
	This PowerShell script checks the given PowerShell script file(s) for validity.
.PARAMETER filePattern
	Specifies the file pattern to the PowerShell file(s)
.EXAMPLE
	PS> ./check-ps1-file *.ps1
	✅ Valid PowerShell in myfile.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$filePattern = "")

try {
	if ($filePattern -eq "" ) { $path = Read-Host "Enter the file pattern to the PowerShell file(s)" }

	$files = Get-ChildItem -path "$filePattern" -attributes !Directory
	foreach ($file in $files) {
		$syntaxError = @()
		[void][System.Management.Automation.Language.Parser]::ParseFile($file, [ref]$null, [ref]$syntaxError)
		if ("$syntaxError" -ne "") { throw "$syntaxError" }
		"✅ Valid PowerShell in $($file.Name)"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(page generated by convert-ps2md.ps1 as of 06/22/2025 10:37:35)*
