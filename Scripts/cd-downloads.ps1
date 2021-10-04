<#
.SYNOPSIS
	cd-downloads.ps1 
.DESCRIPTION
	Change the working directory to the user's downloads folder
.EXAMPLE
	PS> ./cd-downloads
	📂/home/markus/Downloads
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

$TargetDir = resolve-path "$HOME/Downloads"
if (-not(test-path "$TargetDir" -pathType container)) {
	write-warning "Sorry, the user's downloads folder at 📂$TargetDir does not exist (yet)"
	exit 1
}
set-location "$TargetDir"
"📂$TargetDir"
exit 0 # success
