#!/usr/bin/pwsh
<#
.SYNTAX       go-repos.ps1 
.DESCRIPTION  go to the user's Git repositories folder
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	$TargetDir = resolve-path "$HOME/Repos/"
	set-location "$TargetDir"
	"📂 $TargetDir"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
