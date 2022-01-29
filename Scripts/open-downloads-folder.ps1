<#
.SYNOPSIS
	Opens the user's downloads folder
.DESCRIPTION
	This PowerShell script launches the File Explorer showing the user's downloads folder.
.EXAMPLE
	PS> ./open-downloads-folder
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	$TargetDir = resolve-path "$HOME/Downloads"
	if (-not(test-path "$TargetDir" -pathType container)) {
		throw "Downloads folder at 📂$TargetDir doesn't exist (yet)"
	}
	& "$PSScriptRoot/open-file-explorer.ps1" "$TargetDir"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
