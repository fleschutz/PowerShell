<#
.SYNOPSIS
        Checks the IP address
.DESCRIPTION
        This PowerShell script queries the public IP address and prints it.
.EXAMPLE
        PS> ./check-ip.ps1
	✅ Public IPv4 185.74.219.161, IPv6 2003:f2:6729:fc00:e563:641:3dc2:a628, near Munich
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		$PublicIPv4 = (curl -4 --silent ifconfig.co)
		$PublicIPv6 = (curl -6 --silent ifconfig.co)
		$City = (curl --silent ifconfig.co/city)
	} else {
		$PublicIPv4 = (curl.exe -4 --silent ifconfig.co)
		$PublicIPv6 = (curl.exe -6 --silent ifconfig.co)
		$City = (curl.exe --silent ifconfig.co/city)
	}
	Write-Output "✅ Public IPv4 $PublicIPv4, IPv6 $PublicIPv6, near $City"
	exit 0 # success
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}