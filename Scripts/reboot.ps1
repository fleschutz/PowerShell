#!/bin/powershell
<#
.SYNTAX       ./reboot.ps1
.DESCRIPTION  reboots the local computer (requires admin rights)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

#Requires -RunAsAdministrator

try {
	restart-computer
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
