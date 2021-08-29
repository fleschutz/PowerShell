<#
.SYNOPSIS
	speak-file.ps1 [<file>]
.DESCRIPTION
	Speaks the content of the given text file by text-to-speech (TTS).
.EXAMPLE
	PS> .\speak-file.ps1 C:\MyFile.txt
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$File = "")

try {
	if ($File -eq "") { $File = read-host "Enter path to text file" }

	$Text = Get-Content $File

	$Voice = new-object -ComObject SAPI.SPVoice
	$Result = $Voice.Speak($Text)
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
