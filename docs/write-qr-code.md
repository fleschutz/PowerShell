The *write-qr-code.ps1* Script
===========================

This PowerShell script writes "Hello World" as QR code to the console output.

Parameters
----------
```powershell
/Repos/PowerShell/scripts/write-qr-code.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./write-qr-code.ps1

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
	Writes a QR code
.DESCRIPTION
	This PowerShell script writes "Hello World" as QR code to the console output.
.EXAMPLE
	PS> ./write-qr-code.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

Write-Host "                             " -foregroundColor black -backgroundColor white
Write-Host "                             " -foregroundColor black -backgroundColor white
Write-Host "                             " -foregroundColor black -backgroundColor white
Write-Host "    ▄▄▄▄▄▄▄ ▄ ▄▄▄ ▄▄▄▄▄▄▄    " -foregroundColor black -backgroundColor white
Write-Host "    █ ▄▄▄ █ ▄▄▀█  █ ▄▄▄ █    " -foregroundColor black -backgroundColor white
Write-Host "    █ ███ █ █▀ ▄▀ █ ███ █    " -foregroundColor black -backgroundColor white
Write-Host "    █▄▄▄▄▄█ ▄▀█▀█ █▄▄▄▄▄█    " -foregroundColor black -backgroundColor white
Write-Host "    ▄▄▄▄  ▄ ▄▄▄██▄  ▄▄▄ ▄    " -foregroundColor black -backgroundColor white
Write-Host "    ▀ █ ▀▄▄▀█▀▀█▀█▀█▀▀▀▄█    " -foregroundColor black -backgroundColor white
Write-Host "    ▄▄██▀▀▄▄█ ▄▀▄▄▄▀ ▀ ▀▄    " -foregroundColor black -backgroundColor white
Write-Host "    ▄▄▄▄▄▄▄ ▀▀██▄▄██▄ ▀ ▀    " -foregroundColor black -backgroundColor white
Write-Host "    █ ▄▄▄ █  ▀▄ ▄▀ ▀ ██▀▀    " -foregroundColor black -backgroundColor white
Write-Host "    █ ███ █ █▄  ▄ ▀▄ ▀█▀     " -foregroundColor black -backgroundColor white
Write-Host "    █▄▄▄▄▄█ █▀▄█ ███▀ ▄ ▀    " -foregroundColor black -backgroundColor white
Write-Host "                             " -foregroundColor black -backgroundColor white
Write-Host "                             " -foregroundColor black -backgroundColor white
Write-Host "                             " -foregroundColor black -backgroundColor white

exit 0 # success
```

*(page generated by convert-ps2md.ps1 as of 06/22/2025 10:37:42)*
