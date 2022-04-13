<#
.SYNOPSIS
	Opens the Git repositories folder
.DESCRIPTION
	This script launches the File Explorer with the user's Git repositories folder.
.EXAMPLE
	PS> ./open-repos-folder
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$TargetDir = resolve-path "$HOME/Repos"
	if (-not(test-path "$TargetDir" -pathType container)) {
		throw "Repos folder at 📂$TargetDir doesn't exist (yet)"
	}
	& "$PSScriptRoot/open-file-explorer.ps1" "$TargetDir"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
