<#
.SYNOPSIS
	Exports all scripts as manuals
.DESCRIPTION
	This PowerShell script exports the comment based help of all PowerShell scripts as manuals.
.EXAMPLE
	PS> ./export-to-manuals.ps1
	⏳ (1/2) Reading scripts from: /home/mf/PowerShell/Scripts/*.ps1... 
	⏳ (2/2) Exporting manuals to: /home/mf/PowerShell/Scripts/../Docs...
	✔️ exported 518 PowerShell scripts in 28 sec
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 2

param([string]$FilePattern = "$PSScriptRoot/*.ps1", [string]$TargetDir = "$PSScriptRoot/../Docs")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ (1/2) Reading scripts from: $FilePattern..." 
	$Scripts = Get-ChildItem "$FilePattern"

	"⏳ (2/2) Exporting manuals to: $TargetDir..."
	foreach ($Script in $Scripts) {
		& "$PSScriptRoot/convert-ps2md.ps1" "$Script" > "$TargetDir/$($Script.BaseName).md"
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ exported $($Scripts.Count) PowerShell scripts in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
