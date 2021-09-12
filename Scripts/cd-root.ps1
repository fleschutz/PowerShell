<#
.SYNOPSIS
	cd-root.ps1 
.DESCRIPTION
	Change the working directory to the root directory (C:\ on Windows).
.EXAMPLE
	PS> .\cd-root.ps1 
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

if ($IsLinux) {
	$TargetDir = resolve-path "/"
} else {
	$TargetDir = resolve-path "C:/"
}
if (-not(test-path "$TargetDir" -pathType container)) {
	write-warning "Sorry, the root directory at 📂$TargetDir does not exist (yet)"
	exit 1
}
set-location "$TargetDir"
"📂$TargetDir"
exit 0
