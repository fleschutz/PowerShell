#!/bin/powershell
<#
.SYNTAX         ./poweroff.ps1
.DESCRIPTION	halts the local computer, administrator rights are required 
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

#Requires -RunAsAdministrator

try {
	Stop-Computer
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
