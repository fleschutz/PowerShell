<#
.SYNTAX       cd-up4.ps1
.DESCRIPTION  go four directory levels up
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

$TargetDir = resolve-path "../../../.."
if (-not(test-path "$TargetDir" -pathType leaf)) {
	write-warning "Sorry, directory 📂$TargetDir is missing"
	exit 1
}
set-location "$TargetDir"
"📂$TargetDir"
exit 0
