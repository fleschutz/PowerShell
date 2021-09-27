<#
.SYNOPSIS
	switch-shelly1.ps1 [<Host>] [<TurnMode>] [<Timer>]
.DESCRIPTION
	Switches a Shelly1 device in the local network
	(Host is either a hostname or IP address, TurnMode is either 'on', 'off', or 'toggle')
.EXAMPLE
	PS> ./switch-shelly1 192.168.100.100 toggle 10
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
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
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
