<#
.SYNOPSIS
	Plays all system sounds
.DESCRIPTION
	This PowerShell script plays all operating system sounds.
.EXAMPLE
	PS> ./play-system-sounds.ps1 
	    (listen and enjoy)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function PlaySoundFiles([string]$filePattern) {
	$files = (Get-ChildItem "$filePattern")
	foreach($file in $files) {
		& "$PSScriptRoot/play-mp3.ps1" "$file"
		Start-Sleep -milliseconds 500
	}
}

try {
	if ($IsLinux -or $IsMacOS) { throw "Currently only supported for Windows" }

	$WinDir = Resolve-Path "$env:WINDIR"
        if (-not(Test-Path "$WinDir" -pathType container)) { throw "Windows directory at 📂$Path doesn't exist" }

	Write-Host "`n  Windows System Sounds at $WinDir\Media" -foregroundColor green
	PlaySoundFiles "$WinDir\Media\*.wav"
	PlaySoundFiles "$WinDir\Media\*\*.wav"
	exit 0 # success
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}
