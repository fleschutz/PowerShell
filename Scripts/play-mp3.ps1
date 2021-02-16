#!/bin/powershell
<#
.SYNTAX         ./play-mp3.ps1 [<MP3-file>]
.DESCRIPTION	plays the given MP3 sound file
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($Filename = "")

try {
	if ($Filename -eq "" ) {
		$Filename = read-host "Enter MP3 filename"
	}
	Add-Type -AssemblyName presentationCore
	$mediaPlayer = New-Object system.windows.media.mediaplayer
	$mediaPlayer.open("$Filename")
	$mediaPlayer.play()
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
