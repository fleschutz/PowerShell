<#
.SYNOPSIS
	Checks the BIOS status
.DESCRIPTION
	This PowerShell script queries the BIOS status and prints it.
.EXAMPLE
	PS> ./check-bios.ps1
	✅ BIOS model F6 version ALASKA - 1072009 by American Megatrends Inc.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		Write-Progress "⏳ Querying BIOS details..."
		$Model = (sudo dmidecode -s system-product-name)
		if ("$Model" -ne "") {
			$Version = (sudo dmidecode -s bios-version)
			$RelDate = (sudo dmidecode -s bios-release-date)
			$Manufacturer = (sudo dmidecode -s system-manufacturer)
			Write-Host "✅ BIOS model $Model version $Version of $RelDate by $Manufacturer"
		}
		Write-Progress -completed "."
	} else {
		$BIOS = Get-CimInstance -ClassName Win32_BIOS
		$Model = $BIOS.Name.Trim()
		$Version = $BIOS.Version.Trim()
		$Serial = $BIOS.SerialNumber.Trim()
		$Manufacturer = $BIOS.Manufacturer.Trim()
		if ($Serial -eq "To be filled by O.E.M.") {
			Write-Host "✅ BIOS model $Model version $Version by $Manufacturer"
		} else {
			Write-Host "✅ BIOS model $Model version $Version, S/N $Serial, by $Manufacturer"
		}
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
