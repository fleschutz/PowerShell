﻿<#
.SYNOPSIS
	Opens the autostart folder
.DESCRIPTION
	This PowerShell script launches the File Explorer with the user's autostart folder.
.EXAMPLE
	PS> ./open-auto-start-folder
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	$TargetDir = resolve-path "$HOME/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
	if (-not(test-path "$TargetDir" -pathType container)) {
		throw "Autostart folder at 📂$TargetDir doesn't exist (yet)"
	}
	& "$PSScriptRoot/open-file-explorer.ps1" "$TargetDir"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
