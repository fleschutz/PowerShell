<#
.SYNOPSIS
        Launches the Voice Recorder app
.DESCRIPTION
        This PowerShell script launches the Windows Voice Recorder application.
.EXAMPLE
        PS> ./open-voice-recorder.ps1
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	Start-Process explorer.exe shell:appsFolder\Microsoft.WindowsSoundRecorder_8wekyb3d8bbwe!App
        exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
        exit 1
}
