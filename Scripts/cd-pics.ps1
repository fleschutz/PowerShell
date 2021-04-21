#!/usr/bin/pwsh
<#
.SYNTAX       cd-pics.ps1 
.DESCRIPTION  go to the user's pictures folder 
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	$TargetDir = resolve-path "$HOME/Pictures"
	set-location "$TargetDir"
	"📂$TargetDir"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
