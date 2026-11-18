The 'speak-time.ps1' Script
========================

This PowerShell script speaks the current time.

Parameters
----------
```powershell
PS> ./speak-time.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./speak-time.ps1

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
	Speaks the current time 
.DESCRIPTION
	This PowerShell script speaks the current time.
.EXAMPLE
	PS> ./speak-time.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	[system.threading.thread]::currentThread.currentCulture = [system.globalization.cultureInfo]"en-US"
	$CurrentTime = $((Get-Date).ToShortTimeString())
	& "$PSScriptRoot/speak-english.ps1" "It's $CurrentTime."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (at script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
```

*(page auto-generated from PowerShell script by convert-ps2md.ps1 as of 11/18/2026 14:18:51)*
