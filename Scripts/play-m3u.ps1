<#
.SYNTAX       play-m3u.ps1 [<playlist-file>]
.DESCRIPTION  plays the given playlist (in .M3U file format)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Filename = "")
if ($Filename -eq "" ) { $Filename = read-host "Enter the M3U playlist filename" }

try {
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
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
