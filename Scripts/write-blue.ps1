#!/bin/powershell
<#
.SYNTAX         ./write-blue.ps1 [<text>]
.DESCRIPTION	writes the given text in a blue foreground color
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($Text = "")

try {
	if ($Text -eq "" ) {
		[String]$Text = read-host "Enter text to write"
	}
	write-host -foregroundColor blue $Text
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
