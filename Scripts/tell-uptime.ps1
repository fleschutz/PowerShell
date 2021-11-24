<#
.SYNOPSIS
	Tells the uptime by text-to-speech
.DESCRIPTION
	This script speaks the uptime version by text-to-speech (TTS).
.EXAMPLE
	PS> ./tell-uptime
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	if ($IsLinux) {
		$Uptime = (get-uptime)
	} else {
		$BootTime = Get-WinEvent -ProviderName eventlog | Where-Object {$_.Id -eq 6005} | Select-Object TimeCreated -First 1 
		$TimeNow = Get-Date 
		$Uptime = New-TimeSpan -Start $BootTime.TimeCreated.Date -End $TimeNow
	} 

	$Answer = "I'm up for $($Uptime.Days) days, $($Uptime.Hours) hours, $($Uptime.Minutes) minutes."

	write-output "$Answer"
	& "$PSScriptRoot/speak-english.ps1" "$Answer"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
