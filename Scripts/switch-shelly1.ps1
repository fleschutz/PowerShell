<#
.SYNOPSIS
	Switches a Shelly1 device 
.DESCRIPTION
	This PowerShell script switches a Shelly1 device in the local network.
.PARAMETER Host
	Specifies either the hostname or IP address of the Shelly1 device
.PARAMETER TurnMode
	Specifies either 'on', 'off', or 'toggle'
.PARAMETER Timer
	Specifies the timer in seconds (0 = infinite)
.EXAMPLE
	PS> ./switch-shelly1 192.168.100.100 toggle 10
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$Host = "", [string]$TurnMode = "", [int]$Timer = -999)

try {
	if ($Host -eq "") { $Host = read-host "Enter hostname or IP address of the Shelly1 device" }
	if ($TurnMode -eq "") { $TurnMode = read-host "Enter turn mode (on/off/toggle)" }
	if ($Timer -eq -999) { [int]$Timer = read-host "Enter timer in seconds (0=endless)" }

	$Result = Invoke-RestMethod "http://$($Host)/relay/0?turn=$($TurnMode)&timer=$($Timer)"
	
	"✔️ switched Shelly1 device at $Host to $TurnMode for $Timer sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
