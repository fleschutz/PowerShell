<#
.SYNOPSIS
	Plays a .M3U playlist
.DESCRIPTION
	This PowerShell script plays the given playlist (in .M3U file format)
.PARAMETER filename
	Specifies the path to the playlist
.EXAMPLE
	PS> ./play-m3u.ps1 C:\MyPlaylist.m3u
	   ▶️ Playing '01 Sandy beach - strong waves.mp3' (02:54) ...
	   ...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$filename = "")

try {
	if ($filename -eq "" ) { $filename = Read-Host "Enter the path to the .M3U playlist file" }

	if (-not(Test-Path "$filename" -pathType leaf)) { throw "Can't access playlist file: $filename" }
	$lines = Get-Content $filename

	Add-Type -assemblyName presentationCore
	$MediaPlayer = New-Object system.windows.media.mediaplayer

	foreach ($line in $lines) {
		if ($line[0] -eq "#") { continue }
		if (-not(Test-Path "$line" -pathType leaf)) { throw "Can't access audio file: $line" }
		$fullPath = (Get-ChildItem "$line").fullname

		& "$PSScriptRoot/play-mp3.ps1" $fullPath
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
