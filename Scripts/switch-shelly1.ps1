<#
.SYNTAX       switch-shelly1.ps1 [<host>] [<turn-mode>] [<timer>]
.DESCRIPTION  switches a Shelly1 device in the local network
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Host = "", $TurnMode = "", [int]$Timer = -999)
if ($Host -eq "") { $Host = read-host "Enter hostname or IP address of the Shelly1 device" }
if ($TurnMode -eq "") { $TurnMode = read-host "Enter turn mode (on/off/toggle)" }
if ($Timer -eq -999) { [int]$Timer = read-host "Enter timer in seconds (0=endless)" }

try {
	$Result = Invoke-RestMethod "http://$($Host)/relay/0?turn=$($TurnMode)&timer=$($Timer)"
	
	write-host -foregroundColor green "✔️ Shelly1 device at $Host switched to $TurnMode for $Timer second(s)"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
