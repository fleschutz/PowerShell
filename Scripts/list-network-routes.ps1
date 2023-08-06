<#
.SYNOPSIS
	Lists network routes
.DESCRIPTION
	This PowerShell script lists the network routes on the local computer.
.EXAMPLE
	PS> ./list-network-routes.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	& route print
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
