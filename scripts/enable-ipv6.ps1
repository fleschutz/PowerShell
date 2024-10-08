﻿<#
.SYNOPSIS
	Enables IPv6
.DESCRIPTION
	This PowerShell script enables IPv6 on all network interfaces of the local computer.
.EXAMPLE
	PS> ./enable-ipv6.ps1
	✔ IPv6 is enabled now.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Enable-NetAdapterBinding -Name '*' -ComponentID 'ms_tcpip6'
	"✅ IPv6 is enabled now."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}