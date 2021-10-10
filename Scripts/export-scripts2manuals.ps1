<#
.SYNOPSIS
	Generates manuals from the scripts 
.DESCRIPTION
	This script exports the comment based help of all scripts to the manuals.
.EXAMPLE
	PS> ./export-scripts2manuals.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

#requires -version 2

param([string]$FilePattern = "$PSScriptRoot/*.ps1")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	$Scripts = Get-ChildItem "$FilePattern"
	"Found $($Scripts.Count) scripts, starting export..."

	foreach ($Script in $Scripts) {
		& "$PSScriptRoot/convert-ps2md" "$Script" > "$PSScriptRoot/../Docs/$($Script.BaseName).md"
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ exported $($Scripts.Count) scripts to manuals in $Elapsed sec"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
