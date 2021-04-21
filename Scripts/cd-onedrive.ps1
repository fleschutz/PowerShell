<#
.SYNTAX       cd-onedrive.ps1 
.DESCRIPTION  go to the user's OneDrive folder
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

$TargetDir = resolve-path "$HOME/OneDrive"
if (-not(test-path "$TargetDir" -container leaf)) {
	write-warning "Sorry, directory 📂$TargetDir is missing"
	exit 1
}
set-location "$TargetDir"
"📂$TargetDir"
exit 0
