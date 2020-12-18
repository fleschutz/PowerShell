#!/snap/bin/powershell

# Syntax:       ./switch-shelly1.ps1 [<IP addr>] [<turn mode>] [<timer>]
# Description:	switches a Shelly1 device in the local network
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$IPaddr, [string]$TurnMode, [int]$Timer)
if ($IPaddr -eq "" ) {
	$IPaddr = read-host "Enter IP address of Shelly1 device"
}
if ($TurnMode -eq "" ) {
	$TurnMode = read-host "Enter turn mode (on/off/toggle)"
}
if ($Timer -eq 0 ) {
	[int]$Timer = read-host "Enter timer (0=endless)"
}

try {
	$URL = "http://$($IPaddr)/relay/0?turn=$($TurnMode)&timer=$($Timer)"
	$result = Invoke-RestMethod $URL

	write-host "OK - switched Shelly1 device at $IPaddr to $TurnMode for $Timer second(s)"
	exit 0
} catch {
	Write-Error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
