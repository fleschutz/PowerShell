<#
.SYNOPSIS
	Switches a Shelly1 device 
.DESCRIPTION
	This PowerShell script switches a Shelly1 device in the local network.
.PARAMETER host
	Specifies either the hostname or IP address of the Shelly1 device
.PARAMETER turnMode
	Specifies either 'on', 'off', or 'toggle'
.PARAMETER timer
	Specifies the timer in seconds (0 = infinite)
.EXAMPLE
	PS> ./switch-shelly1 192.168.100.100 toggle 10
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$host = "", [string]$turnMode = "", [int]$timer = -999)

try {
	if ($host -eq "") { $host = Read-Host "Enter the hostname or IP address of the Shelly1 device" }
	if ($turnMode -eq "") { $turnMode = Read-Host "Enter the turn mode (on/off/toggle)" }
	if ($timer -eq -999) { [int]$timer = Read-Host "Enter the timer in seconds (0=endless)" }

	$result = Invoke-RestMethod "http://$($host)/relay/0?turn=$($turnMode)&timer=$($timer)"
	
	"✅ Switched Shelly1 device at $host to $turnMode for $timer sec."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
