#!/usr/bin/pwsh
<#
.SYNTAX       cd-up.ps1 [<number>]
.DESCRIPTION  go one or multiple directories up
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param([int]$Number = 1)

try {
	$TargetDir = ""
	do {
		$TargetDir += "../"
		$Number--
	} while ($Number -ne 0)
	$TargetDir = resolve-path $TargetDir
	set-location "$TargetDir"
	"📂$TargetDir"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
