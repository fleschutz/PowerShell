The *cd-root.ps1* Script
===========================

This PowerShell script changes the current working directory to the root directory (C:\ on Windows).

Parameters
----------
```powershell
/Repos/PowerShell/scripts/cd-root.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./cd-root.ps1
📂C:\ with 7 folders and 0 files entered.

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
	Sets the working dir to the root dir
.DESCRIPTION
	This PowerShell script changes the current working directory to the root directory (C:\ on Windows).
.EXAMPLE
	PS> ./cd-root.ps1
	📂C:\ with 7 folders and 0 files entered.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux -or $IsMacOS) { $path = "/" } else { $path = "C:\" }
	Set-Location "$path"
	$folders = Get-ChildItem $path -attributes Directory
	$files = Get-ChildItem $path -attributes !Directory
	"📂$path with $($folders.Count) folders and $($files.Count) files entered."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
```

*(page generated by convert-ps2md.ps1 as of 06/22/2025 10:37:34)*
