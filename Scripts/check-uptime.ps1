<#
.SYNOPSIS
	Determines the uptime 
.DESCRIPTION
	This script determines and says the uptime by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-uptime
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
		$Reply = "Up for 1 day, "
	} else {
		$Reply = "Up for $Days days, "
	}
	if ($Hours -eq "1") {
		$Reply += "1 hour "
	} else {
		$Reply += "$Hours hours "
	}
	if ($Minutes -eq "1") {
		$Reply += "and 1 minute."
	} else {
		$Reply += "and $Minutes minutes."
	}
	"✔️ $Reply"
	& "$PSScriptRoot/speak-english.ps1" "$Reply"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
