<#
.SYNOPSIS
	Exports all scripts as manuals
.DESCRIPTION
	This script exports the comment based help of all PowerShell scripts as manuals.
.EXAMPLE
	PS> ./export-scripts2manuals.ps1
	Found 264 scripts, starting export to /home/markus/PowerShell/Docs...
	✔️ exported 264 scripts as manuals in 28 sec
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

#requires -version 2

param([string]$FilePattern = "$PSScriptRoot/*.ps1", [string]$TargetDir = "$PSScriptRoot/../Docs")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	$Scripts = Get-ChildItem "$FilePattern"
	"Found $($Scripts.Count) scripts, starting export to $TargetDir..."

	foreach ($Script in $Scripts) {
		& "$PSScriptRoot/convert-ps2md" "$Script" > "$TargetDir/$($Script.BaseName).md"
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ exported $($Scripts.Count) scripts as manuals in $Elapsed sec"
	exit 0 # success
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
