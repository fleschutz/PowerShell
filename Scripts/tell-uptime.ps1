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
	
	$Days = $Uptime.Days
	$Hours = $Uptime.Hours
	$Minutes = $Uptime.Minutes 

	if ($Days -eq "1") {
		$Answer = "I'm up for 1 day, "
	} else {
		$Answer = "I'm up for $Days days, "
	}
	if ($Hours -eq "1") {
		$Answer += "1 hour "
	} else {
		$Answer += "$Hours hours "
	}
	if ($Minutes -eq "1") {
		$Answer += "and 1 minute."
	} else {
		$Answer += "and $Minutes minutes."
	}

	& "$PSScriptRoot/speak-english.ps1" "$Answer"
	write-output "$Answer"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
