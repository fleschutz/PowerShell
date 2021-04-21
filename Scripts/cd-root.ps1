<#
.SYNTAX       cd-root.ps1 
.DESCRIPTION  go to the root directory (C: on Windows)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

if ($IsLinux) {
	$TargetDir = resolve-path "/"
} else {
	$TargetDir = resolve-path "C:/"
}
if (-not(test-path "$TargetDir" -pathType leaf)) {
	write-warning "Sorry, directory 📂$TargetDir is missing"
	exit 1
}
set-location "$TargetDir"
"📂$TargetDir"
exit 0
