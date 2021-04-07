#!/usr/bin/pwsh
<#
.SYNTAX       ./play-mp3.ps1 [<MP3-file>]
.DESCRIPTION  plays the given sound file (MP3 file format)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Filename = "")

if ($Filename -eq "" ) {
	$Filename = read-host "Enter the MP3 filename"
}

try {
	add-type -assemblyName PresentationCore
	$MediaPlayer = new-object System.Windows.Media.MediaPlayer

	$FullPath = (get-childItem $Filename).fullname
	do {
		$MediaPlayer.open($FullPath)
		$Duration = $MediaPlayer.NaturalDuration.TimeSpan.TotalMilliseconds
	} until ($Duration)
	write-progress "Playing $Filename ..."
	$MediaPlayer.Volume = 1
	$MediaPlayer.play()
	start-sleep -milliseconds $Duration
	$MediaPlayer.stop()
	$MediaPlayer.close()

	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
