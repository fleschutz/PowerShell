<#
.SYNOPSIS
	Simulates the human presence against burglars
.DESCRIPTION
	This PowerShell script simulates the human presence against burglars.
.PARAMETER IPaddress
	Specifies the IP address of the Shelly1 device
.EXAMPLE
	PS> ./simulate-presence 192.168.100.100
.NOTES
	Author: Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$IPaddress = "")

try {
	if ($IPaddress -eq "" ) { $IPaddress = read-host "Enter IP address of Shelly1 device" }

	for ([int]$i = 0; $i -lt 1000; $i++) {
		& "$PSScriptRoot/switch-shelly1.ps1" $IPaddress on 0
		start-sleep -s 10
		& "$PSScriptRoot/switch-shelly1.ps1" $IPaddress off 0
		start-sleep -s 60
	}

	"✔️  Done."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
