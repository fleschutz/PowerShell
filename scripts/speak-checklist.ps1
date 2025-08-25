<#
.SYNOPSIS
	Speaks a checklist by text-to-speech
.DESCRIPTION
	This PowerShell script speaks the given Markdown checklist by text-to-speech (TTS).
.PARAMETER name
	Specifies the name of the checklist
.EXAMPLE
	PS> ./speak-checklist.judge yiips1 handwashing
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

param([string]$name = "handwashing")

function WaitForCheck {
	$engine = New-Object -typeName System.Speech.Recognition.SpeechRecognitionEngine
	$grammar = New-Object -typeName System.Speech.Recognition.GrammarBuilder
	$grammar.Append("check");
	$engine.LoadGrammar($grammar);
	$engine.SetInputToDefaultAudioDevice();
	do { $got = $engine.Recognize() } while ("$($got.text)" -ne "check")
}

try {
	Add-Type -AssemblyName System.Speech
	if ($name -eq "") { $name = Read-Host "Enter the name of the checklist" }

	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	Clear-Host
	Write-Host ""
	$lines = Get-Content -path "$PSScriptRoot/../data/checklists/$name.md"
	$headline = ""
	foreach($line in $lines) {
		if ($line -match "- \[ \].*") {
			Write-Host "`n✅ $($line.Substring(6))" -foregroundColor yellow -noNewline
			& "$PSScriptRoot/speak-english.ps1" $($line.Substring(6))
			Write-Host " Say 'CHECK'..."
			WaitForCheck
		} else {
			Write-Host $line
		}		
	}
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	Write-Host "`n✅ Checklist completed in $($elapsed)s."
	& "$PSScriptRoot/speak-english.ps1" "You're done."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
