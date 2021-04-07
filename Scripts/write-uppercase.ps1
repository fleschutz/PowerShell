#!/usr/bin/pwsh
<#
.SYNTAX       write-uppercase.ps1 [<text>]
.DESCRIPTION  writes the given text in uppercase letters
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Text = "")
if ($Text -eq "" ) { $Text = read-host "Enter the text to write" }

try {
	write-output $Text.ToUpper()
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
