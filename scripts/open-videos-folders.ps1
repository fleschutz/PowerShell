<#
.SYNOPSIS
	Opens the user's videos folder
.DESCRIPTION
	This script launches the File Explorer with the user's videos folder.
.EXAMPLE
	PS> ./open-videos-folder.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	$TargetDir = Resolve-Path "$HOME/Videos"
	if (-not(Test-Path "$TargetDir" -pathType container)) {
		throw "Videos folder at 📂$TargetDir doesn't exist (yet)"
	}
	& "$PSScriptRoot/open-file-explorer.ps1" "$TargetDir"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
