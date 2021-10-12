<#
.SYNOPSIS
	Sets the working directory to the user's SSH folder
.DESCRIPTION
	This script changes the working directory to the user's SSH folder.
.EXAMPLE
	PS> ./cd-ssh
	📂/home/markus/.ssh
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

$TargetDir = resolve-path "$HOME/.ssh"
if (-not(test-path "$TargetDir" -pathType container)) {
	write-warning "Sorry, the user's SSH folder at 📂$TargetDir does not exist (yet)"
	exit 1
}
set-location "$TargetDir"
"📂$TargetDir"
exit 0 # success
