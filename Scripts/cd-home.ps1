<#
.SYNOPSIS
	Sets the working directory to the user's home directory
.DESCRIPTION
	This script changes the working directory to the user's home directory.
.EXAMPLE
	PS> ./cd-home
	📂/home/markus
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

$TargetDir = resolve-path "$HOME"
if (-not(test-path "$TargetDir" -pathType container)) {
	write-warning "Sorry, the user's home directory at 📂$TargetDir does not exist (yet)"
	exit 1
}
set-location "$TargetDir"
"📂$TargetDir"
exit 0 # success
