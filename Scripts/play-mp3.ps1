<#
.SYNOPSIS
	play-mp3.ps1 [<MP3-file>]
.DESCRIPTION
	Plays the given sound file (MP3 file format).
.EXAMPLE
	PS> .\play-mp3.ps1 C:\thunder.mp3
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$Filename = "")

try {
	if ($Filename -eq "" ) { $Filename = read-host "Enter the MP3 filename" }

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
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
