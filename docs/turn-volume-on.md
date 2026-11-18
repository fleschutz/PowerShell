The 'turn-volume-on.ps1' Script
========================

This PowerShell script immediately unmutes the audio output.

Parameters
----------
```powershell
PS> ./turn-volume-on.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> .\turn-volume-on

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
	Turn audio on
.DESCRIPTION
	This PowerShell script immediately unmutes the audio output.
.EXAMPLE
	PS> .\turn-volume-on
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$obj = new-object -com wscript.shell
	$obj.SendKeys([char]173)
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
```

*(page auto-generated from PowerShell script by convert-ps2md.ps1 as of 11/18/2026 14:18:52)*
