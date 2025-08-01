The *new-symlink.ps1* Script
===========================

This PowerShell script creates a new symbolic link file, linking to a target.

Parameters
----------
```powershell
/Repos/PowerShell/scripts/new-symlink.ps1 [[-symlink] <String>] [[-target] <String>] [<CommonParameters>]

-symlink <String>
    Specifies the file path to the new symlink file
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

-target <String>
    Specifies the file path to the target
    
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
PS> ./new-symlink.ps1 C:\User\Markus\Windows C:\Windows
✅ Created new symlink 'C:\User\Markus\Windows' linking to: C:\Windows

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
	Creates a new symlink
.DESCRIPTION
	This PowerShell script creates a new symbolic link file, linking to a target.
.PARAMETER symlink
	Specifies the file path to the new symlink file
.PARAMETER target
	Specifies the file path to the target
.EXAMPLE
	PS> ./new-symlink.ps1 C:\User\Markus\Windows C:\Windows
	✅ Created new symlink 'C:\User\Markus\Windows' linking to: C:\Windows
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$symlink = "", [string]$target = "")

try {
	if ($symlink -eq "" ) { $symlink = Read-Host "Enter new symlink filename" }
	if ($target -eq "" ) { $target = Read-Host "Enter path to target" }

	New-Item -path "$symlink" -itemType SymbolicLink -value "$target"
	if ($lastExitCode -ne 0) { throw "Command 'New-Item' has failed" }

	"✅ Created new symlink '$symlink' linking to: $target"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(page generated by convert-ps2md.ps1 as of 06/22/2025 10:37:39)*
