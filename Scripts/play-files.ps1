<#
.SYNOPSIS
	play-files.ps1 [<pattern>]
.DESCRIPTION
	Plays the given audio files (supporting MP3 and WAV format)
.EXAMPLE
	PS> ./play-files *.mp3
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$Pattern = "*")

try {
	$Files = (get-childItem -path "$Pattern" -attributes !Directory)
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
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
