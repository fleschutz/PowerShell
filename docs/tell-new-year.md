The *tell-new-year.ps1* Script
===========================

This PowerShell script calculates the time until New Year and replies by text-to-speech (TTS).

Parameters
----------
```powershell
/Repos/PowerShell/scripts/tell-new-year.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./tell-new-year.ps1
(listen and enjoy)

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
	Tells the time until New Year
.DESCRIPTION
	This PowerShell script calculates the time until New Year and replies by text-to-speech (TTS).
.EXAMPLE
	PS> ./tell-new-year.ps1
	(listen and enjoy)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$now = [DateTime]::Now
	$NewYear = [Datetime]("12/31/" + $now.Year)
	$days = ($NewYear – $now).Days + 1
	if ($days -gt 1) {
		& "$PSScriptRoot/speak-english.ps1" "New Year is in $days days."
	} elseif ($days -eq 1) {
		& "$PSScriptRoot/speak-english.ps1" "New Year is tomorrow."
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(page generated by convert-ps2md.ps1 as of 06/22/2025 10:37:41)*
