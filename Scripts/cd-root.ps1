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
if (-not(test-path "$TargetDir" -pathType container)) {
	write-warning "Sorry, there is no folder 📂$TargetDir (yet)"
	exit 1
}
set-location "$TargetDir"
"📂$TargetDir"
exit 0
