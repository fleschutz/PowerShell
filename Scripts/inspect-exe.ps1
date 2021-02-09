#!/bin/powershell
<#
.SYNTAX         ./inspect-exe.ps1 [<path-to-exe-file>]
.DESCRIPTION	prints basic information of the given executable file
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param([string]$PathToExe)

try {
	if ($PathToExe -eq "" ) {
		$PathToExe = read-host "Enter path to executable file"
	}
	get-childitem $PathToExe | % {$_.VersionInfo} | Select *
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
