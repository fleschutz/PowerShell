#!/snap/bin/powershell

# Syntax:       ./switch-shelly1.ps1 [<IP addr>] [<turn-mode>] [<timer>]
# Description:	switches a Shelly1 device in the local network
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([String]$IPaddr, [String]$TurnMode, [Int]$Timer)

try {
	if ($IPaddr -eq "" ) {
		[String]$IPaddr = read-host "Enter IP address of the Shelly1 device"
	}
	if ($TurnMode -eq "" ) {
		[String]$TurnMode = read-host "Enter turn mode (on/off/toggle)"
	}
	if ($Timer -eq 0 ) {
		[Int]$Timer = read-host "Enter timer (0=endless)"
	}

	$Result = Invoke-RestMethod "http://$($IPaddr)/relay/0?turn=$($TurnMode)&timer=$($Timer)"
	write-output "OK - switched Shelly1 device at $IPaddr to $TurnMode for $Timer second(s)"
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
