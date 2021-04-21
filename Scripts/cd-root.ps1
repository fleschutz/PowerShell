#!/usr/bin/pwsh
<#
.SYNTAX       cd-root.ps1 
.DESCRIPTION  go to the root directory (C: on Windows)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	if ($IsLinux) {
		$TargetDir = resolve-path "/"
	} else {
		$TargetDir = resolve-path "C:/"
	}
	set-location "$TargetDir"
	"📂$TargetDir"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
