<#
.SYNTAX       voice-control.ps1 
.DESCRIPTION  executes the PowerShell scripts by voice
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

[double]$MinConfidence = 0.04
$PathToRepo = "$PSScriptRoot/.."

try {
	write-output "Init speech recognition engine..."
	[system.threading.thread]::currentthread.currentculture=[system.globalization.cultureinfo]"en-US"
	[void][System.Reflection.Assembly]::LoadWithPartialName("System.Speech") 
	$speechRecogEng = [System.Speech.Recognition.SpeechRecognitionEngine]::new()
	#$speechRecogEng.InitialSilenceTimeout = 15
	$speechRecogEng.SetInputToDefaultAudioDevice()

	write-output "Learn script files..."
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

	write-output "Learn internal command (exit)..."
	$grammar2 = [System.Speech.Recognition.GrammarBuilder]::new()
	$grammar2.Append("exit")
	$speechRecogEng.LoadGrammar($grammar2)

	write-output "NOTE: make sure the microphone volume is not too silent or too loud!"

	write-output "Listening now ($Count voice commands)..."
	while ($true) {
		$recognized = $speechRecogEng.Recognize()
		if ($recognized.confidence -lt $MinConfidence) { write-host -noNewline "?"; continue }
		$myWords = $recognized.text
		foreach ($Item in $Items) {
			$Name = $Item.Name.Split('.')[0]
			if ($Name -eq $myWords) {
				write-host "$Name ($($recognized.confidence) %)..."
				& "./$Item"
				break
			}
		}
		if ($myWords -match "exit") { write-host -noNewline "$Name ($($recognized.confidence) %)"; break }
	} 
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
