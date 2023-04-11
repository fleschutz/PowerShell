<#
.SYNOPSIS
	Checks the BIOS status
.DESCRIPTION
	This PowerShell script queries the BIOS status and prints it.
.EXAMPLE
	PS> ./check-bios
	✅ BIOS F6 by American Megatrends Inc. (version ALASKA - 1072009, S/N NXA82EV0EBB0760)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		Write-Progress "⏳ Querying BIOS..."
		$Model = (sudo dmidecode -s system-product-name)
		if ("$Model" -ne "") {
			$Manufacturer = (sudo dmidecode -s system-manufacturer)
			$Version = (sudo dmidecode -s bios-version)
			$RelDate = (sudo dmidecode -s bios-release-date)
			Write-Host "✅ BIOS $Model by $Manufacturer ($Version release of $RelDate)"
		}
		Write-Progress -completed "."
	} else {
		Write-Progress "⏳ Querying BIOS..."
		$BIOS = Get-CimInstance -ClassName Win32_BIOS
		$Model = $BIOS.Name.Trim()
		$Manufacturer = $BIOS.Manufacturer.Trim()
		$Serial = $BIOS.SerialNumber.Trim()
		$Version = $BIOS.Version.Trim()
		Write-Progress -completed "."
		Write-Host "✅ BIOS $Model by $Manufacturer (version $Version, S/N $Serial)"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}