<#
.SYNOPSIS
	Sets the working directory to four directory levels up
.DESCRIPTION
	This script changes the working directory to four directory levels up.
.EXAMPLE
	PS> ./cd-up4
	(four levels up)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

try {
	$TargetDir = resolve-path "../../../.."
	if (-not(test-path "$TargetDir" -pathType container)) {
		throw "Folder at 📂$TargetDir doesn't exist (yet)"
	}
	set-location "$TargetDir"
	"📂$TargetDir"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
