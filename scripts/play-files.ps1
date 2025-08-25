<#
.SYNOPSIS
	Plays audio files
.DESCRIPTION
	This PowerShell script plays the given audio files (supporting .MP3 and .WAV format).
.PARAMETER filePattern
	Specifies the file pattern ('*' by default)
.EXAMPLE
	PS> ./play-files.ps1 *.mp3
	   ▶️ Playing '01 Sandy beaches - strong waves.mp3' (02:54) ...
	   ...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$filePattern = "*")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	$files = (Get-ChildItem -path "$filePattern" -attributes !Directory)
	[int]$count = 0
	foreach ($file in $files) {
		if ("$file" -like "*.mp3") {
			& "$PSScriptRoot/play-mp3.ps1" "$file"
			$count++
		} elseif ("$File" -like "*.wav") {
			& "$PSScriptRoot/play-mp3.ps1" "$file"
			$count++
		} else {
			"Skipping $file (no audio file)..."
		}
	}
        [int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Played $count audio files for $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
