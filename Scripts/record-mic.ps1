<#
.SYNOPSIS
        record-mic.ps1 [<seconds>] [<path>]
.DESCRIPTION
        Records audio from the microphone (WAV or MP3 format) 
.EXAMPLE
        PS> .\record-mic.ps1
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author:  Markus Fleschutz
        License: CC0
#>

param([int]$seconds = 10, [string]$path = "$HOME/mic.wav")

try {
	Add-Type -Path PSCore.dll
	$Recording = [PSCore.LoopbackRecorder] $Recording::StartRecording("$path") 
	Start-Sleep -s $seconds
	$Recording::StopRecording()
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
