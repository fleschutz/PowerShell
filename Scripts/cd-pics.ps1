<#
.SYNOPSIS
	cd-pics.ps1 
.DESCRIPTION
	Change the working directory to the user's pictures folder
.EXAMPLE
	PS> ./cd-pics
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

$TargetDir = resolve-path "$HOME/Pictures"
if (-not(test-path "$TargetDir" -pathType container)) {
	write-warning "Sorry, the user's pictures folder at 📂$TargetDir does not exist (yet)"
	exit 1
}
set-location "$TargetDir"
"📂$TargetDir"
exit 0 # success
