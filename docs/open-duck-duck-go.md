The *open-duck-duck-go.ps1* Script
===========================

This PowerShell script launches the Web browser with the DuckDuckGo website.

Parameters
----------
```powershell
/Repos/PowerShell/scripts/open-duck-duck-go.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./open-duck-duck-go

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
	Opens the DuckDuckGo website 
.DESCRIPTION
	This PowerShell script launches the Web browser with the DuckDuckGo website.
.EXAMPLE
	PS> ./open-duck-duck-go
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://duckduckgo.com"
exit 0 # success
```

*(page generated by convert-ps2md.ps1 as of 06/22/2025 10:37:39)*
