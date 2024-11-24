<#
.SYNOPSIS
	Speaks a checklist by text-to-speech
.DESCRIPTION
	This PowerShell script speaks the given checklist by text-to-speech (TTS).
.PARAMETER name
	Specifies the name of the checklist
.EXAMPLE
	PS> ./speak-checklist.ps1 handwashing
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$name = "handwashing")

function WaitForCheck {
	Add-Type -AssemblyName System.Speech
	$engine = New-Object -typeName System.Speech.Recognition.SpeechRecognitionEngine
	$grammar = New-Object -typeName System.Speech.Recognition.GrammarBuilder
	$grammar.Append("check");
	$engine.LoadGrammar($grammar);
	$engine.InitialSilenceTimeout = 5
	$engine.SetInputToDefaultAudioDevice();
	do {
		$recognized = $engine.Recognize();
    	} while ("$($recognized.text)" -ne "check")
}

try {
	if ($name -eq "") { $name = Read-Host "Enter the name of the checklist" }

	Clear-Host
	$lines = Get-Content -path "$PSScriptRoot/../data/checklists/$name.txt"
	$step = 1
	foreach($line in $lines) {
		if ($line -like "HEAD*") { & "$PSScriptRoot/write-big.ps1" "$($line.substring(5))"; continue }
		""			
		Write-Host "$($step). $line" -foregroundColor yellow
		& "$PSScriptRoot/speak-english.ps1" $line
		Write-Host "   Say <CHECK> to continue..."
		Write-Host ""
		WaitForCheck
		$step++
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
