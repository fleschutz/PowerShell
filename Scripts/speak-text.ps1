#!/snap/bin/powershell
<#
.SYNTAX         ./speak-text.ps1 [<text>]
.DESCRIPTION	speaks the given text by text-to-speech (TTS)
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

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
