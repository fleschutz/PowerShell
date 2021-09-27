<#
.SYNOPSIS
	cd-up4.ps1
.DESCRIPTION
	Change the working directory to four directory levels up
.EXAMPLE
	PS> ./cd-up4
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

$TargetDir = resolve-path "../../../.."
if (-not(test-path "$TargetDir" -pathType container)) {
	write-warning "Sorry, the folder 📂$TargetDir does not exist (yet)"
	exit 1
}
set-location "$TargetDir"
"📂$TargetDir"
exit 0 # success
