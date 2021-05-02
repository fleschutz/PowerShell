<#
.SYNTAX       play-files.ps1 [<file(s)>]
.DESCRIPTION  plays the given audio files (supporting MP3 and WAV format)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Files = "*")

try {
	foreach ($File in (get-childItem -path "$Files" -attributes !Directory)) {
		if ("$File" -like "*.mp3") {
			& "$PSScriptRoot/play-mp3.ps1" "$File"
		} elseif ("$File" -like "*.wav") {
			& "$PSScriptRoot/play-mp3.ps1" "$File"
		} else {
			"Skipping $File ..."
		}
	}
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
