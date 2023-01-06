<#
.SYNOPSIS
	Check the firewall
.DESCRIPTION
	This PowerShell script queries and prints firewall details.
.EXAMPLE
	PS> ./check-firewall
	✅ AMD Ryzen 5 5500U with Radeon Graphics (CPU0, 2100MHz, 31.3°C)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		# TODO
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
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}