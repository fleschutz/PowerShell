<#
.SYNOPSIS
	Plays a playlist (.M3U format)
.DESCRIPTION
	This PowerShell script plays the given playlist (in .M3U file format)
.PARAMETER filename
	Specifies the path to the playlist
.EXAMPLE
	PS> ./play-m3u C:\MyPlaylist.m3u
	(listen and enjoy)
.NOTES
	Author: Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$filename = "")

try {
	if ($filename -eq "" ) { $filename = read-host "Enter the M3U playlist filename" }

	if (-not(test-path "$filename" -pathType leaf)) { throw "Can't access playlist file: $filename" }
	$Lines = get-content $filename

	add-type -assemblyName presentationCore
	$MediaPlayer = new-object system.windows.media.mediaplayer

	for ([int]$i=0; $i -lt $Lines.Count; $i++) {
		$Line = $Lines[$i]
		if ($Line[0] -eq "#") { continue }
		if (-not(test-path "$Line" -pathType leaf)) { throw "Can't access audio file: $Line" }
		$FullPath = (get-childItem "$Line").fullname
		$filename = (get-item "$FullPath").name
		do {
			$MediaPlayer.open("$FullPath")
			$Milliseconds = $MediaPlayer.NaturalDuration.TimeSpan.TotalMilliseconds
		} until ($Milliseconds)
		[int]$Minutes = $Milliseconds / 60000
		[int]$Seconds = ($Milliseconds / 1000) % 60
		"▶️Playing 🎵$filename ($($Minutes.ToString('00')):$($Seconds.ToString('00'))) ..."
		$MediaPlayer.Volume = 1
		$MediaPlayer.play()
		start-sleep -milliseconds $Milliseconds
		$MediaPlayer.stop()
		$MediaPlayer.close()
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
