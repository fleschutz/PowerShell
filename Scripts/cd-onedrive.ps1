<#
.SYNOPSIS
	cd-onedrive.ps1 
.DESCRIPTION
	Go to the user's OneDrive folder
.EXAMPLE
	PS> .\cd-onedrive.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

$TargetDir = resolve-path "$HOME/OneDrive"
if (-not(test-path "$TargetDir" -pathType container)) {
	write-warning "Sorry, there is no folder 📂$TargetDir (yet)"
	exit 1
}
set-location "$TargetDir"
"📂$TargetDir"
exit 0
