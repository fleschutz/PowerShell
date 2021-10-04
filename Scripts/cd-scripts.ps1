<#
.SYNOPSIS
	cd-scripts.ps1 
.DESCRIPTION
	Change the working directory to the PowerShell scripts folder
.EXAMPLE
	PS> ./cd-scripts
	📂/home/markus/PowerShell/Scripts
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

$TargetDir = resolve-path "$PSScriptRoot"
if (-not(test-path "$TargetDir" -pathType container)) {
	write-warning "Sorry, the PowerShell scripts folder at 📂$TargetDir does not exist (yet)"
	exit 1
}
set-location "$TargetDir"
"📂$TargetDir"
exit 0 # success
