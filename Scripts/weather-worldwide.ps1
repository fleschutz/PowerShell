#!/bin/powershell
<#
.SYNTAX         ./weather-worldwide.ps1
.DESCRIPTION	prints the current weather of cities world-wide
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

$Cities="Hawaii","Los Angeles","Mexico City","Miami","New York","Rio de Janeiro","Paris","London","Berlin","Cape Town","Dubai","Mumbai","Singapore","Hong Kong","Peking","Tokyo","Sydney"

try {
	write-output "Current Weather Report World-wide"
	write-output "================================="
	write-output ""
	foreach($City in $Cities) {
		$Line = (Invoke-WebRequest http://wttr.in/${City}?format="%l:+%c+%t+%p+%h+%P+%w +%S ->+%s" -UserAgent "curl").Content
		write-output "* $Line"
	}
	write-output ""
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
