<#
.SYNTAX       speak-file.ps1 [<file>]
.DESCRIPTION  speaks the content of the given text file by text-to-speech (TTS)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($File = "")
if ($File -eq "") { $File = read-host "Enter path to text file" }

try {
	$Text = Get-Content $File

	$Voice = new-object -ComObject SAPI.SPVoice
	$Result = $Voice.Speak($Text)
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
