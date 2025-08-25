<#
.SYNOPSIS
	Plays all system sounds
.DESCRIPTION
	This PowerShell script plays all available system sounds.
.EXAMPLE
	PS> ./play-system-sounds.ps1 
	(listen and enjoy)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function GetPathToSystemMedia {
	if ($IsLinux) {
		throw "Not supported for Linux yet"
	} elseif ($IsMacOS) {
		 throw "Not supported for MacOS yet"
	} else {
		$WinPath = Resolve-Path "$env:WINDIR"
        	if (-not(Test-Path "$WinPath" -pathType container)) { throw "Windows folder at 📂$WinPath doesn't exist" }

		$MediaPath = "$WinPath\Media"
        	if (-not(Test-Path "$MediaPath" -pathType container)) { throw "Windows media at 📂$MediaPath doesn't exist" }

		return $MediaPath
	}
}

function PlaySoundFiles([string]$filePattern) {
	$files = Get-ChildItem "$filePattern"
	foreach($file in $files) {
		& "$PSScriptRoot/play-mp3.ps1" "$file"
		Start-Sleep -milliseconds 500
	}
}

try {
	$path = GetPathToSystemMedia
	Write-Host "`n   S Y S T E M    S O U N D S     (at: $path)" -foregroundColor green
	PlaySoundFiles "$path\*.wav"
	PlaySoundFiles "$path\*\*.wav"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
        exit 1
}
