#!/bin/powershell
<#
.SYNTAX         ./write-green.ps1 [<text>]
.DESCRIPTION	writes the given text in a green foreground color
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param([string]$Text = "")

try {
	if ($Text -eq "" ) {
		[string]$Text = read-host "Enter text to write"
	}
	write-host -foregroundColor green $Text
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
