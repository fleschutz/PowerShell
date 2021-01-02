#!/snap/bin/powershell
<#
.SYNTAX         ./switch-shelly1.ps1 [<IP-address>] [<turn-mode>] [<timer>]
.DESCRIPTION	switches a Shelly1 device in the local network
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param([string]$IPaddr = "", [string]$TurnMode = "", [int]$Timer = -999)

try {
	if ($IPaddr -eq "") {
		[String]$IPaddr = read-host "Enter IP address of the Shelly1 device"
	}
	if ($TurnMode -eq "") {
		[String]$TurnMode = read-host "Enter turn mode (on/off/toggle)"
	}
	if ($Timer -eq -999) {
		[Int]$Timer = read-host "Enter timer (0=endless)"
	}

	$Result = Invoke-RestMethod "http://$($IPaddr)/relay/0?turn=$($TurnMode)&timer=$($Timer)"
	write-output "OK - switched Shelly1 device at $IPaddr to $TurnMode for $Timer second(s)"
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
