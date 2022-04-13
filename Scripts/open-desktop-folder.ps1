<#
.SYNOPSIS
	Opens the desktop folder
.DESCRIPTION
	This PowerShell script launches the File Explorer with the user's desktop folder.
.EXAMPLE
	PS> ./open-desktop-folder
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	$TargetDir = resolve-path "$HOME/Desktop"
	if (-not(test-path "$TargetDir" -pathType container)) {
		throw "Desktop folder at 📂$TargetDir doesn't exist (yet)"
	}
	& "$PSScriptRoot/open-file-explorer.ps1" "$TargetDir"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
