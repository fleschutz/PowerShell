<#
.SYNOPSIS
	Lists the (cached) network neighbors
.DESCRIPTION
	This PowerShell script lists all cached network neighbors of the local computer.
.EXAMPLE
	PS> ./list-network-neighbors.ps1

	Name                  InterfaceAlias     IPAddress       LinkLayerAddress        State
	----                  --------------     ---------       ----------------        -----
	<<>8:8:8<?;55;=55;    Ethernet           224.0.0.251     01-00-5E-00-00-FB   Permanent
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		& ip neigh
	} elseif ($IsMacOS) {
		& ip neigh
	} else {
		Get-NetNeighbor -includeAllCompartments | Format-Table -property InterfaceAlias,IPAddress,LinkLayerAddress,State -autoSize
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
