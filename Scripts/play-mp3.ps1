#!/bin/powershell
<#
.SYNTAX         ./play-mp3.ps1 [<MP3-file>]
.DESCRIPTION	plays the given sound file (MP3 file format)
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($Filename = "")

if ($Filename -eq "" ) {
	$Filename = read-host "Enter the MP3 filename"
}

try {
	add-type -assemblyName presentationCore
	$MediaPlayer = new-object system.windows.media.mediaplayer
	$MediaPlayer.open("$Filename")
	$MediaPlayer.play()

	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
