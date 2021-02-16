#!/bin/powershell
<#
.SYNTAX         ./write-uppercase.ps1 [<text>]
.DESCRIPTION	writes the given text in uppercase letters
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param([string]$Text = "")

try {
	if ($Text -eq "" ) {
		[string]$Text = read-host "Enter text to write"
	}
	write-output $Text.ToUpper()
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
