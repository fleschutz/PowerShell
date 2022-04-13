<#
.SYNOPSIS
	Opens the Dropbox folder
.DESCRIPTION
	This PowerShell script launches the File Explorer with the user's Dropbox folder.
.EXAMPLE
	PS> ./open-dropbox-folder
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	$TargetDirs = resolve-path "$HOME/Dropbox*"
	foreach($TargetDir in $TargetDirs) {
		& "$PSScriptRoot/open-file-explorer.ps1" "$TargetDir"
		exit 0 # success
	}
	throw "No Dropbox folder at 📂$HOME/Dropbox"
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
