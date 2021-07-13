<#
.SYNOPSIS
	cd-home.ps1 
.DESCRIPTION
	Go to the user's home folder
.EXAMPLE
	PS> .\cd-home.ps1 
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

$TargetDir = resolve-path "$HOME"
if (-not(test-path "$TargetDir" -pathType container)) {
	write-warning "Sorry, there is no folder 📂$TargetDir (yet)"
	exit 1
}
set-location "$TargetDir"
"📂$TargetDir"
exit 0
