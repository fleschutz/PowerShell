#!/snap/bin/powershell

# Syntax:	./speak-text.ps1 [<text>]
# Description:	speaks the given text by text-to-speech (TTS)
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$Text)
try {
	if ($Text -eq "") {
		$Text = read-host "Enter text to speak"
	}

	$voice = New-Object ComObject SAPI.SPVoice
	$voice.Speak($Text);
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
