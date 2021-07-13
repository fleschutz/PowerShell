<#
.SYNOPSIS
	cd-repos.ps1 
.DESCRIPTION
	Go to the user's Git repositories folder
.EXAMPLE
	PS> .\cd-repos.ps1 
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

$TargetDir = resolve-path "$HOME/Repos"
if (-not(test-path "$TargetDir" -pathType container)) {
	write-warning "Sorry, there is no folder 📂$TargetDir (yet)"
	exit 1
}
set-location "$TargetDir"
"📂$TargetDir"
exit 0
