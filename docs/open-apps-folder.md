The *open-apps-folder.ps1* Script
===========================

This PowerShell script launches the File Explorer showing the UWP apps folder.

Parameters
----------
```powershell
/Repos/PowerShell/scripts/open-apps-folder.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./open-apps-folder

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
	Opens the Apps folder
.DESCRIPTION
	This PowerShell script launches the File Explorer showing the UWP apps folder.
.EXAMPLE
	PS> ./open-apps-folder
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/open-file-explorer.ps1" "shell:AppsFolder"
exit 0 # success

```

*(page generated by convert-ps2md.ps1 as of 06/22/2025 10:37:39)*
