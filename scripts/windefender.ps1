<#
.SYNOPSIS
	Configure Windows defender 
.DESCRIPTION
	This script can enable / disable and show Windows defender real time monitoring!
.EXAMPLE
	PS> ./windefender.ps1
.LINK
	https://github.com/pakoti/Awesome_Sysadmin
.NOTES
	Author: Dark Master | License: CC0-1,0
#>



$defender = Get-MpPreference

$userInput = Read-Host "Enter an option: 
[1] Disable real time monitoring 
[2] Enable real time monitoring 
[3] Check status
"

switch($userInput) {
1 {
$defender.DisableRealtimeMonitoring = $true
$defender | Set-MpPreference
Write-Host "Real-time monitoring of Windows Defender has been disabled."
break
}
2 {
$defender.DisableRealtimeMonitoring = $false
$defender | Set-MpPreference
Write-Host "Real-time monitoring of Windows Defender has been enabled."
break
}
3 {
if($defender.DisableRealtimeMonitoring) {
Write-Host "Real-time monitoring of Windows Defender is currently disabled."
} else {
Write-Host "Real-time monitoring of Windows Defender is currently enabled."
}
break
}
default {
Write-Host "Invalid option selected."
break
}
}
