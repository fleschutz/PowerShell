<#
.SYNOPSIS
	cd-music.ps1 
.DESCRIPTION
	Change the working directory to the user's music folder
.EXAMPLE
	PS> ./cd-music
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

$TargetDir = resolve-path "$HOME/Music"
if (-not(test-path "$TargetDir" -pathType container)) {
	write-warning "Sorry, the user's music folder at 📂$TargetDir does not exist (yet)"
	exit 1
}
set-location "$TargetDir"
"📂$TargetDir"
exit 0
