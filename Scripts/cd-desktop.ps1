<#
.SYNOPSIS
	cd-desktop.ps1 
.DESCRIPTION
	Change the working directory to the user's desktop folder
.EXAMPLE
	PS> ./cd-desktop
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

$TargetDir = resolve-path "$HOME/Desktop"
if (-not(test-path "$TargetDir" -pathType container)) {
	write-warning "Sorry, the desktop folder at 📂$TargetDir does not exist (yet)"
	exit 1
}
set-location "$TargetDir"
"📂$TargetDir"
exit 0 # success
