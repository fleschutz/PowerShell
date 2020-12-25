#!/snap/bin/powershell

# Syntax:	./speak-file.ps1 [<file>]
# Description:	speaks the content of the given text file by text-to-speech (TTS)
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$File)
try {
	if ($File -eq "") {
		$File = read-host "Enter path to file"
	}
	$Text = Get-Content $File

	$voice = New-Object ComObject SAPI.SPVoice
	$voice.Speak($Text);
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
