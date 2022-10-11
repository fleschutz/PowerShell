<#
.SYNOPSIS
	Checks the VPN connection(s)
.DESCRIPTION
	This PowerShell script queries and prints the status of any VPN connection.
.EXAMPLE
	PS> ./check-vpn
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$FoundOne = $false
	if ($IsLinux) {
		# TODO
	} else {
		$Connections = (Get-VPNConnection)
		foreach($Connection in $Connections) {
			"✅ VPN $($Connection.Name) is $($Connection.ConnectionStatus)."
			$FoundOne = $true
		}
	}
	if (!$FoundOne) { "⚠️ No VPN connection." }
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
