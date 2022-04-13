<#
.SYNOPSIS
	Opens the home folder
.DESCRIPTION
	This script launches the File Explorer with the user's home folder.
.EXAMPLE
	PS> ./open-home-folder
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$TargetDir = resolve-path "$HOME"
	if (-not(test-path "$TargetDir" -pathType container)) {
		throw "Home folder at 📂$TargetDir doesn't exist (yet)"
	}
	& "$PSScriptRoot/open-file-explorer.ps1" "$TargetDir"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
