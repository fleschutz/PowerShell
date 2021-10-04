<#
.SYNOPSIS
	Change the working directory to the user's OneDrive folder
.DESCRIPTION
	cd-onedrive.ps1 
.EXAMPLE
	PS> ./cd-onedrive
	📂/home/markus/OneDrive
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

$TargetDir = resolve-path "$HOME/OneDrive"
if (-not(test-path "$TargetDir" -pathType container)) {
	write-warning "Sorry, the user's OneDrive folder 📂$TargetDir does not exist (yet)"
	exit 1
}
set-location "$TargetDir"
"📂$TargetDir"
exit 0 # success
