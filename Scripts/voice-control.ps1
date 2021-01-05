#!/snap/bin/powershell
<#
.SYNTAX         ./voice-control.ps1 
.DESCRIPTION	executes the PowerShell scripts by voice
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

write-output "Initializing the speech recognition engine..."
$speechRecogEng = [System.Speech.Recognition.SpeechRecognitionEngine]::new();
$speechRecogEng.InitialSilenceTimeout = 15
$speechRecogEng.SetInputToDefaultAudioDevice();

write-output "Loading the grammar..."
$grammar1 = [System.Speech.Recognition.GrammarBuilder]::new();
$grammar1.Append("hello");
$speechRecogEng.LoadGrammar($grammar1);

$grammar2 = [System.Speech.Recognition.GrammarBuilder]::new();
$grammar2.Append("open notepad");
$speechRecogEng.LoadGrammar($grammar2);

$grammar3 = [System.Speech.Recognition.GrammarBuilder]::new();
$grammar3.Append("exit");
$speechRecogEng.LoadGrammar($grammar3);

write-output "Listening now..."
$done = $false;
while (!$done) {
	$recognized = $speechRecogEng.Recognize()
	write-host -nonewline "."
	if ($recognized.confidence -lt 0.30) { continue }
	$myWords = $recognized.text
	write-host -nonewline "$myWords ($($recognized.confidence) %)"
	if ($myWords -match "hello") {
		continue
	}
	if ($myWords -match "open notepad") {
		continue
	}
	if ($myWords -match "exit") {
		$done = $true
	}
}

exit 0
