#!/bin/powershell
<#
.SYNTAX         ./play-m3u.ps1 [<playlist-file>]
.DESCRIPTION	plays the given playlist (M3U file format)
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($Filename = "")

if ($Filename -eq "" ) {
	$Filename = read-host "Enter the M3U playlist filename"
}

try {
	$Lines = get-content $Filename

	add-type -assemblyName presentationCore
	$MediaPlayer = new-object system.windows.media.mediaplayer

	for ([int]$i=0; $i -lt $Lines.Count; $i++) {
		$Line = $Lines[$i]
		if ($Line[0] -ne "#") {
			$MediaPlayer.open("$Line")
			$MediaPlayer.play()
		}
	}
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
