#!/usr/bin/pwsh
<#
.SYNTAX       go-desktop.ps1 
.DESCRIPTION  go to the user's desktop folder
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	$TargetDir = resolve-path "$HOME/Desktop/"
	set-location "$TargetDir"
	"📂$TargetDir"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
