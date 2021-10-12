<#
.SYNOPSIS
	Sets the working directory to three directory levels up
.DESCRIPTION
	This script changes the working directory to three directory levels up.
.EXAMPLE
	PS> ./cd-up3
	(three levels up)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

$TargetDir = resolve-path "../../.."
if (-not(test-path "$TargetDir" -pathType container)) {
	write-warning "Sorry, the folder 📂$TargetDir does not exist (yet)"
	exit 1
}
set-location "$TargetDir"
"📂$TargetDir"
exit 0 # success
