<#
.SYNOPSIS
	cd-home.ps1 
.DESCRIPTION
	Change the working directory to the user's home directory
.EXAMPLE
	PS> .\cd-home.ps1 
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

$TargetDir = resolve-path "$HOME"
if (-not(test-path "$TargetDir" -pathType container)) {
	write-error "Home directory 📂$TargetDir does not exist"
	exit 1
}
set-location "$TargetDir"
"📂$TargetDir"
exit 0
