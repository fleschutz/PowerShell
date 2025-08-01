The *uninstall-outlook.ps1* Script
===========================

This PowerShell script uninstalls Outlook for Windows.

Parameters
----------
```powershell
/Repos/PowerShell/scripts/uninstall-outlook.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./uninstall-outlook.ps1

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
	Uninstalls Outlook
.DESCRIPTION
	This PowerShell script uninstalls Outlook for Windows.
.EXAMPLE
	PS> ./uninstall-outlook.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"⏳ Uninstalling Outlook for Windows..."

	Remove-AppxPackage -AllUsers -Package (Get-AppxPackage Microsoft.OutlookForWindows).PackageFullName
	
	"✅ Outlook for Windows has been removed."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(page generated by convert-ps2md.ps1 as of 06/22/2025 10:37:41)*
