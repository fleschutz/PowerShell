<#
.SYNTAX       cd-music.ps1 
.DESCRIPTION  go to the user's music folder
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

$TargetDir = resolve-path "$HOME/Music"
if (-not(test-path "$TargetDir" -pathType leaf)) {
	write-warning "Sorry, directory 📂$TargetDir is missing"
	exit 1
}
set-location "$TargetDir"
"📂$TargetDir"
exit 0
