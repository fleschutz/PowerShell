<#
.SYNOPSIS
	Simulate a human against burglars
.DESCRIPTION
	This PowerShell script simulates the human presence against burglars. It switches a Shelly1 device on and off.
.PARAMETER IPaddress
	Specifies the IP address of the Shelly1 device
.EXAMPLE
	PS> ./simulate-presence 192.168.100.100
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$IPaddress = "")

try {
	if ($IPaddress -eq "" ) { $IPaddress = Read-Host "Enter IP address of the Shelly1 device" }

	for ([int]$i = 0; $i -lt 1000; $i++) {
		& "$PSScriptRoot/switch-shelly1.ps1" $IPaddress on 0
		Start-Sleep -seconds 10 # on for 10 seconds
		& "$PSScriptRoot/switch-shelly1.ps1" $IPaddress off 0
		Start-Sleep -seconds 60 # off for 60 seconds
	}
	"✅ Done."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
