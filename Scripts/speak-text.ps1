#!/snap/bin/powershell

# Syntax:	./speak-text.ps1 [<text>]
# Description:	speaks the given text by text-to-speech (TTS)
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$Text)
if ($Text -eq "") {
	$Text = "Hello World!"
}

try {
	$voice = New-Object ComObject SAPI.SPVoice
	$voice.Speak($Text);
	exit 0
} catch {
	Write-Error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
