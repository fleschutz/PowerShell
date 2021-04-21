#!/usr/bin/pwsh
<#
.SYNTAX       cd-dropbox.ps1 
.DESCRIPTION  go to the user's Dropbox folder
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	$TargetDir = resolve-path "$HOME/Dropbox"
	set-location "$TargetDir"
	"📂$TargetDir"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
