#!/usr/bin/pwsh
<#
.SYNTAX       go-music.ps1 
.DESCRIPTION  go to the user's music folder
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	$TargetDir = resolve-path "$HOME/Music/"
	set-location "$TargetDir"
	"  📂$TargetDir"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
