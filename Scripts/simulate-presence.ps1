#!/usr/bin/pwsh
<#
.SYNTAX       ./simulate-presence.ps1 [<IP-address>]
.DESCRIPTION  simulates the human presence against burglars
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($IPaddress = "")

if ($IPaddress -eq "" ) {
	$IPaddress = read-host "Enter IP address of Shelly1 device"
}

try {
	for ([int]$i = 0; $i -lt 1000; $i++) {
		& ./switch-shelly1.ps1 $IPaddress on 0
		start-sleep -s 10
		& ./switch-shelly1.ps1 $IPaddress off 0
		start-sleep -s 60
	}
	write-host -foregroundColor green "Done."
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
