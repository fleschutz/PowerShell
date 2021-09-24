<#
.SYNOPSIS
	cd-repos.ps1 
.DESCRIPTION
	Change the working directory to the user's Git repositories folder
.EXAMPLE
	PS> ./cd-repos
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

$TargetDir = resolve-path "$HOME/Repos"
if (-not(test-path "$TargetDir" -pathType container)) {
	write-warning "Sorry, the user's Git repositories folder at 📂$TargetDir does not exist (yet)"
	exit 1
}
set-location "$TargetDir"
"📂$TargetDir"
exit 0
