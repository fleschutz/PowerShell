<#
.SYNOPSIS
	play-m3u.ps1 [<playlist-file>]
.DESCRIPTION
	Plays the given playlist (in .M3U file format).
.EXAMPLE
	PS> .\play-m3u.ps1 C:\MyPlaylist.m3u
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$Filename = "")

try {
	if ($Filename -eq "" ) { $Filename = read-host "Enter the M3U playlist filename" }

	if (-not(test-path "$Filename" -pathType leaf)) { throw "Can't access playlist file: $Filename" }
	$Lines = get-content $Filename

	add-type -assemblyName presentationCore
	$MediaPlayer = new-object system.windows.media.mediaplayer

	for ([int]$i=0; $i -lt $Lines.Count; $i++) {
		$Line = $Lines[$i]
		if ($Line[0] -eq "#") { continue }
		if (-not(test-path "$Line" -pathType leaf)) { throw "Can't access audio file: $Line" }
		$FullPath = (get-childItem "$Line").fullname
		$Filename = (get-item "$FullPath").name
		do {
			$MediaPlayer.open("$FullPath")
			$Milliseconds = $MediaPlayer.NaturalDuration.TimeSpan.TotalMilliseconds
		} until ($Milliseconds)
		[int]$Minutes = $Milliseconds / 60000
		[int]$Seconds = ($Milliseconds / 1000) % 60
		"▶️Playing 🎵$Filename ($($Minutes.ToString('00')):$($Seconds.ToString('00'))) ..."
		$MediaPlayer.Volume = 1
		$MediaPlayer.play()
		start-sleep -milliseconds $Milliseconds
		$MediaPlayer.stop()
		$MediaPlayer.close()
	}
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
