<#
.SYNOPSIS
	Exports all scripts to Serenade for voice control
.DESCRIPTION
	This script exports all PowerShell scripts to Serenade.ai for voice control.
.EXAMPLE
	PS> ./export-to-serenade.ps1
	Found 264 scripts, starting export to C:\Users\Markus/.serenade/scripts/PowerShell.js...
	✔️ exported 264 PowerShell scripts for Serenade voice control in 22 sec
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

#requires -version 2

param([string]$FilePattern = "$PSScriptRoot/*.ps1", [string]$TargetFile = "$HOME/.serenade/scripts/PowerShell.js")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	$Scripts = Get-ChildItem "$FilePattern"
	"Found $($Scripts.Count) scripts, exporting to $TargetFile..."

	"/* Exported by export-scripts2serenade.ps1 */" | Set-Content "$TargetFile"
	foreach ($Script in $Scripts) {
		$ScriptName = $Script.basename
		$Keyword = $ScriptName -replace "-"," "
		""                                                         | Add-Content "$TargetFile"
		"serenade.global().command(`"$Keyword`", async (api) => {" | Add-Content "$TargetFile"
		"await api.focusOrLaunchApplication(`"terminal`");"        | Add-Content "$TargetFile"
		"await api.typeText(`"$ScriptName.ps1`");"                 | Add-Content "$TargetFile"
		"await api.pressKey(`"return`");"                          | Add-Content "$TargetFile"
		"});"                                                      | Add-Content "$TargetFile"
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ exported $($Scripts.Count) PowerShell scripts for Serenade voice control in $Elapsed sec"
	exit 0 # success
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
