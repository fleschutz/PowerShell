#!/bin/powershell
<#
.SYNTAX         ./write-green.ps1 [<text>]
.DESCRIPTION	writes the given text in a green foreground color
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($Text = "")

if ($Text -eq "" ) {
	$Text = read-host "Enter the text to write"
}

try {
	write-host -foregroundColor green $Text
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
