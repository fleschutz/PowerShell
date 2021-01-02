#!/snap/bin/powershell
<#
.SYNTAX         ./speak-time.ps1
.DESCRIPTION	speaks the current time by text-to-speech (TTS)
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

try {
	$Voice = new-object -ComObject SAPI.SPVoice
	$Text = "The current time is $((Get-Date).ToShortTimeString())"
	$Result = $Voice.Speak($Text)
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
