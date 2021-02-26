#!/bin/powershell
<#
.SYNTAX         ./check-windows-system-files.ps1 
.DESCRIPTION	checks the validity of the Windows system files 
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

try {
	sfc /verifyOnly

	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
