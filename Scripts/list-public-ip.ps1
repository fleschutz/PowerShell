<#
.SYNOPSIS
        Lists the public IP address(es)
.DESCRIPTION
        This PowerShell script queries the public IP address(es) and prints it.
.EXAMPLE
        PS> ./list-public-ip.ps1
	✅ Public IPv4 185.72.209.161, IPv6 2003:f2:6128:fc01:e503:601:30c2:a028 near Munich
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		$publicIPv4 = (curl -4 --silent ifconfig.co)
		$publicIPv6 = (curl -6 --silent ifconfig.co)
		$city = (curl --silent ifconfig.co/city)
	} else {
		$publicIPv4 = (curl.exe -4 --silent ifconfig.co)
		$publicIPv6 = (curl.exe -6 --silent ifconfig.co)
		$city = (curl.exe --silent ifconfig.co/city)
	}
	if ("$publicIPv4" -eq "") { $publicIPv4 = "N/A" }
	if ("$publicIPv6" -eq "") { $publicIPv6 = "N/A" }
	if ("$city" -eq "") { $city = "unknown" }
	Write-Output "✅ Public IPv4 $publicIPv4, IPv6 $publicIPv6 near $City"
	exit 0 # success
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}
