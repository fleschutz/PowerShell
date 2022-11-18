<#
.SYNOPSIS
	Exports all scripts as manuals
.DESCRIPTION
	This PowerShell script exports the comment based help of all PowerShell scripts as manuals.
.EXAMPLE
	PS> ./export-to-manuals.ps1
	Found 264 scripts, exporting them to /home/markus/PowerShell/Docs...
	✔️ exported 264 PowerShell scripts in 28 sec
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 2

param([string]$FilePattern = "$PSScriptRoot/*.ps1", [string]$TargetDir = "$PSScriptRoot/../Docs")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1/2) Reading scripts from: $FilePattern...  " -noNewline
	$Scripts = Get-ChildItem "$FilePattern"
	Write-Host "found $($Scripts.Count) scripts"

	Write-Host "⏳ (2/2) Exporting manuals to: $TargetDir..."
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
