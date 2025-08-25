<#
.SYNOPSIS
	Checks the firewall status
.DESCRIPTION
	This PowerShell script queries the status of the firewall and prints it.
.EXAMPLE
	PS> ./check-firewall.ps1
	✅ Firewall enabled
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		Write-Host "✅ Firewall " -noNewline
		& sudo ufw status
	} else {
		$enabled = (gp 'HKLM:\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile').EnableFirewall
		if ($enabled) {
			Write-Host "✅ Firewall enabled"
		} else {
			Write-Host "⚠️ Firewall disabled"
		}
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
