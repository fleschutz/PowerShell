#!/usr/bin/pwsh
<#
.SYNTAX       go-downloads.ps1 
.DESCRIPTION  go to the user's downloads folder
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	$TargetDir = resolve-path "$HOME/Downloads/"
	set-location "$TargetDir"
	"  📂$TargetDir"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
