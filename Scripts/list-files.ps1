#!/bin/powershell
<#
.SYNTAX         ./list-files.ps1 [<folder>]
.DESCRIPTION	lists all files in the given folder and also in every subfolder
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param([string]$Folder)

try {
	if ($Folder -eq "" ) {
		[string]$Folder = read-host "Enter path to folder"
	}
	Get-ChildItem -path $Folder -recurse | select FullName
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
