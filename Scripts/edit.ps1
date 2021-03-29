#!/bin/powershell
<#
.SYNTAX       ./edit.ps1 <filename>
.DESCRIPTION  starts the built-in text editor to edit the given file
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Filename = "")

try {
	& notepad.exe "$Filename"
	if ($lastExitCode -ne "0") { throw "Can't execute 'notepad.exet' - make sure notepad.exe is installed and available" }

	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
