<#
.SYNOPSIS
	Exports scripts to Serenade 
.DESCRIPTION
	This PowerShell script exports all scripts to Serenade to execute them by voice.
.PARAMETER WakeWord
	Specifies the wake word (none by default)
.PARAMETER FilePattern
	Specifies the file pattern for the scripts ("$PSScriptRoot/*.ps1" by default)
.PARAMETER Application
	Specifies the application to be used
.PARAMETER TargetFile
	Specifies the target file ("$HOME\.serenade\scripts\PowerShell.js" by default)
.EXAMPLE
	PS> ./export-to-serenade.ps1 Computer
	⏳ Found 534 PowerShell scripts...
	⏳ Writing custom JavaScript file: C:\Users\Markus\.serenade\scripts\PowerShell.js...
	✔️ Exported to Serenade with wake word "Computer" in 3 sec
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

#requires -version 2

param([string]$WakeWord = "", [string]$FilePattern = "$PSScriptRoot/*.ps1", [string]$Application = "terminal", [string]$TargetFile = "$HOME\.serenade\scripts\PowerShell.js")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	$Scripts = Get-ChildItem "$FilePattern"
	"⏳ Found $($Scripts.Count) PowerShell scripts..."
	"⏳ Writing custom JavaScript file: $TargetFile..."

	"/* DO NOT EDIT! This file has been generated automatically by export-to-serenade.ps1 */" | Set-Content "$TargetFile"
	foreach ($Script in $Scripts) {
		$ScriptName = $Script.basename
		$Keyword = $ScriptName -replace "-"," "
		"serenade.global().command(`"$($WakeWord.toLower()) $Keyword`",async(api)=>{await api.focusApplication(`"$Application`");await api.pressKey(`"return`");await api.typeText(`"$ScriptName.ps1`");await api.pressKey(`"return`");});" | Add-Content "$TargetFile"
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ Exported to Serenade with wake word `"$WakeWord`" in $Elapsed sec"
	exit 0 # success
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
