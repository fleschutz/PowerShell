#!/snap/bin/powershell
<#
.SYNTAX         ./voice-control.ps1 
.DESCRIPTION	executes the PowerShell scripts by voice
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

[double]$MinConfidence = 0.05
$PathToRepo = "$PSScriptRoot/.."

try {
	write-output "Initializing the speech recognition engine..."
	$null = [Reflection.Assembly]::LoadWithPartialName("System.Speech") 
	$speechRecogEng = [System.Speech.Recognition.SpeechRecognitionEngine]::new()
	#$speechRecogEng.InitialSilenceTimeout = 15
	$speechRecogEng.SetInputToDefaultAudioDevice()

	write-output "Loading the grammar..."
	$Items = get-childItem -path "$PathToRepo/Scripts/"
	$Count = 0
	foreach ($Item in $Items) {
		$Name = $Item.Name.Split('.')[0]
		if ($Name -eq "") { continue }
		$grammar1 = [System.Speech.Recognition.GrammarBuilder]::new()
		$grammar1.Append($Name)
		$speechRecogEng.LoadGrammar($grammar1)
		$Count++
	}

	$grammar2 = [System.Speech.Recognition.GrammarBuilder]::new()
	$grammar2.Append("exit")
	$speechRecogEng.LoadGrammar($grammar2)

	write-output "Got $Count voice commands, listening now..."
	$done = $false
	do {
		$recognized = $speechRecogEng.Recognize()
		write-host -nonewline "."
		if ($recognized.confidence -lt $MinConfidence) { continue }
		$myWords = $recognized.text
		write-host -nonewline "$myWords ($($recognized.confidence) %)"
		if ($myWords -match "hello") {
			continue
		}
		if ($myWords -match "open notepad") {
			continue
		}
		if ($myWords -match "exit") {
			break
		}
	} until ($done)
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
