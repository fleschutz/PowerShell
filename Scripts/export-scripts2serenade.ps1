<#
.SYNOPSIS
	Exports all scripts to Serenade for voice control
.DESCRIPTION
	This script exports all PowerShell scripts to Serenade.ai for voice control.
.EXAMPLE
	PS> ./export-scripts2serenade.ps1
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
	"Found $($Scripts.Count) scripts, starting export to $TargetFile..."

	copy-file "$PSScriptRoot/Data/Templates/serenade.txt" "$TargetFile" -force
	foreach ($Script in $Scripts) {
		$ScriptName = $Script.basename
		$Keyword = $ScriptName -replace "-"," "
		"" >> $TargetFile
		"serenade.global().command(`"$Keyword`", async (api) => {" >> $TargetFile
		"await api.focusOrLaunchApplication(`"terminal`");" >> $TargetFile
		"await api.typeText(`"$ScriptName.ps1`");" >> $TargetFile
		"await api.pressKey(`"return`");" >> $TargetFile
		"});" >> $TargetFile
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ exported $($Scripts.Count) scripts to Serenade in $Elapsed sec"
	exit 0 # success
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
