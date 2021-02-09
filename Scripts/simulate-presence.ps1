#!/bin/powershell
<#
.SYNTAX         ./simulate-presence.ps1 [<IP-address>]
.DESCRIPTION	simulates the human presence against burglars
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param([string]IPaddress)

for ([int]$i = 0; $i -lt 1000; $i++) {
	./switch-shelly1 $IPaddress on 0
	sleep 60
	./switch-shelly1 $IPaddress off 0
	sleep 10
}
exit 0
