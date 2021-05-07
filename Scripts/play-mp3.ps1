<#
.SYNTAX       play-mp3.ps1 [<MP3-file>]
.DESCRIPTION  plays the given sound file (MP3 file format)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Filename = "")
if ($Filename -eq "" ) { $Filename = read-host "Enter the MP3 filename" }

try {
	if (-not(test-path "$Filename" -pathType leaf)) { throw "Can't access audio file: $Filename" }
	$FullPath = (get-childItem $Filename).fullname
	$Filename = (get-item "$FullPath").name

	add-type -assemblyName PresentationCore
	$MediaPlayer = new-object System.Windows.Media.MediaPlayer

	do {
		$MediaPlayer.open($FullPath)
		$Milliseconds = $MediaPlayer.NaturalDuration.TimeSpan.TotalMilliseconds
	} until ($Milliseconds)

	[int]$Minutes = $Milliseconds / 60000
	[int]$Seconds = ($Milliseconds / 1000) % 60
	"▶️ Playing 🎵$Filename for $($Minutes.ToString('00')):$($Seconds.ToString('00')) sec..."
	$PreviousTitle = $host.ui.RawUI.WindowTitle 
	$host.ui.RawUI.WindowTitle = "▶️ $Filename"
	$MediaPlayer.Volume = 1
	$MediaPlayer.play()
	start-sleep -milliseconds $Milliseconds
	$MediaPlayer.stop()
	$MediaPlayer.close()
	$host.ui.RawUI.WindowTitle = $PreviousTitle

	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
