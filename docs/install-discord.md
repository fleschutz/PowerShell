The *install-discord.ps1* Script
===========================

This PowerShell script installs Discord from the Microsoft Store.

Parameters
----------
```powershell
/Repos/PowerShell/scripts/install-discord.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./install-discord.ps1

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
	Installs Discord
.DESCRIPTION
	This PowerShell script installs Discord from the Microsoft Store.
.EXAMPLE
	PS> ./install-discord.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Installing Discord, please wait..."

	& winget install "Discord" --source msstore --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne 0) { throw "'winget install' failed" }

	"Discord installed successfully."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(page generated by convert-ps2md.ps1 as of 06/22/2025 10:37:36)*
