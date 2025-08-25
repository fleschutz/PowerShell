<#
.SYNOPSIS
	Lists network connections
.DESCRIPTION
	This PowerShell script lists all active network connections on the local computer.
.EXAMPLE
	PS> ./list-network-connections.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	& netstat -n
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
