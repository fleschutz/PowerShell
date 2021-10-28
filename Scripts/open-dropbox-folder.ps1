<#
.SYNOPSIS
	Opens the user's Dropbox folder
.DESCRIPTION
	This script launches the File and showing the user's Dropbox folder.
.EXAMPLE
	PS> ./open-dropbox-folder
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$TargetDir = resolve-path "$HOME/Dropbox"
	if (-not(test-path "$TargetDir" -pathType container)) {
		throw "Dropbox folder at 📂$TargetDir doesn't exist (yet)"
	}
	& "$PSScriptRoot/open-file-explorer.ps1" "$TargetDir"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
