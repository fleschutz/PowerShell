The *check-motherboard.ps1* Script
===========================

This PowerShell script lists the motherboard details.

Parameters
----------
```powershell
/Repos/PowerShell/scripts/check-motherboard.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./check-motherboard.ps1
✅ Motherboard Calla_LC by LN

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
	Lists motherboard details
.DESCRIPTION
	This PowerShell script lists the motherboard details.
.EXAMPLE
	PS> ./check-motherboard.ps1
	✅ Motherboard Calla_LC by LN
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
	} else {
		$details = Get-WmiObject -Class Win32_BaseBoard
		"✅ Motherboard $($details.Product) by $($details.Manufacturer)"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(page generated by convert-ps2md.ps1 as of 06/22/2025 10:37:34)*
