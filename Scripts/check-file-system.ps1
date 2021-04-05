#!/bin/powershell
<#
.SYNTAX       ./check-file-system.ps1 [<drive>] 
.DESCRIPTION  checks the validity of the file system (needs admin rights)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

#Requires -RunAsAdministrator

param($Drive = "")

if ($Drive -eq "" ) {
	$Drive = read-host "Enter drive (letter) to check"
}

try {
	repair-volume -driveLetter $Drive -scan

	write-host -foregroundColor green "OK - drive $Drive is non-corrupt"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
