#!/usr/bin/pwsh
<#
.SYNTAX       cd-up.ps1 
.DESCRIPTION  go one or multiple directories up
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	$TargetDir = resolve-path ".."
	set-location "$TargetDir"
	"📂$TargetDir"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
