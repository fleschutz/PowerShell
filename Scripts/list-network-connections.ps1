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
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
