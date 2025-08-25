<#
.SYNOPSIS
	Disables IPv6 (requires admin rights)
.DESCRIPTION
	This PowerShell script disables IPv6 on all network interfaces of the local computer (requires administrator rights).
.EXAMPLE
	PS> ./disable-ipv6.ps1
	✔ IPv6 is disabled now.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Disable-NetAdapterBinding -Name '*' -ComponentID 'ms_tcpip6'
	"✅ IPv6 is disabled now."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
