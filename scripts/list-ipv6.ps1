<#
.SYNOPSIS
	Lists IPv6 states
.DESCRIPTION
	This PowerShell script lists the state of IPv6 on all network interfaces of the local computer.
.EXAMPLE
	PS> ./list-ipv6.ps1
	Name                         Enabled
	----                         -------
	Ethernet                        True
	vEthernet (WSL)                 True
	Bluetooth Network Connection    True
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Get-NetAdapterBinding -name '*' -componentID 'ms_tcpip6' | Format-Table -autoSize -property Name,Enabled 
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
