<#
.SYNOPSIS
	Plays audio files (MP3 and WAV)
.DESCRIPTION
	This PowerShell script plays the given audio files (supporting MP3 and WAV format).
.PARAMETER FilePattern
	Specifies the file pattern
.EXAMPLE
	PS> ./play-files *.mp3
.NOTES
	Author: Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$FilePattern = "*")

try {
	$Files = (get-childItem -path "$FilePattern" -attributes !Directory)
	"Playing $($Files.Count) files ..."
	foreach ($File in $Files) {
		if ("$File" -like "*.mp3") {
			& "$PSScriptRoot/play-mp3.ps1" "$File"
		} elseif ("$File" -like "*.wav") {
			& "$PSScriptRoot/play-mp3.ps1" "$File"
		} else {
			"Skipping $File ..."
		}
	}
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
