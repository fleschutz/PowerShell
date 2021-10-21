<#
.SYNOPSIS
	Exports all scripts to Serenade for voice control
.DESCRIPTION
	This script exports all PowerShell scripts to Serenade to execute them by voice.
.PARAMETER WakeWord
	Specifies the wakeword (none by default)
.PARAMETER FilePattern
	Specifies the file pattern for the scripts ("$PSScriptRoot/*.ps1" by default)
.PARAMETER TargetFile
	Specifies the target file ("$HOME/.serenade/scripts/custom.js" by default)
.EXAMPLE
	PS> ./export-to-serenade.ps1 Computer
	⏳ Exporting 264 scripts to C:\Users\Markus/.serenade/scripts/custom.js...
	✔️ exported 264 PowerShell scripts to Serenade in 22 sec
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

#requires -version 2

param([string]$WakeWord = "", [string]$FilePattern = "$PSScriptRoot/*.ps1", [string]$TargetFile = "$HOME/.serenade/scripts/custom.js")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	$Scripts = Get-ChildItem "$FilePattern"
	"⏳ Exporting $($Scripts.Count) scripts to $TargetFile..."

	"/* NOTE: This file has been generated automatically by export-to-serenade.ps1 */" | Set-Content "$TargetFile"
	foreach ($Script in $Scripts) {
		$ScriptName = $Script.basename
		$Keyword = $ScriptName -replace "-"," "
		""                                                         | Add-Content "$TargetFile"
		"serenade.global().command(`"$WakeWord $Keyword`", async (api) => {" | Add-Content "$TargetFile"
		"await api.focusOrLaunchApplication(`"terminal`");"        | Add-Content "$TargetFile"
		"await api.typeText(`"$ScriptName.ps1`");"                 | Add-Content "$TargetFile"
		"await api.pressKey(`"return`");"                          | Add-Content "$TargetFile"
		"});"                                                      | Add-Content "$TargetFile"
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ exported $($Scripts.Count) PowerShell scripts to Serenade in $Elapsed sec"
	exit 0 # success
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
