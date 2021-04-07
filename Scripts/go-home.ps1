#!/usr/bin/pwsh
<#
.SYNTAX       ./go-home.ps1 
.DESCRIPTION  go to the user's home folder
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	set-location $HOME
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
