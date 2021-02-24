#!/bin/powershell
<#
.SYNTAX         ./list-profiles.ps1
.DESCRIPTION	lists your PowerShell profiles
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

try {
	$PROFILE | select-object *

	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
