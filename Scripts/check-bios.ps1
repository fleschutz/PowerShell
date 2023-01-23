<#
.SYNOPSIS
	Checks the BIOS
.DESCRIPTION
	This PowerShell script queries the BIOS status and prints it.
.EXAMPLE
	PS> ./check-bios
	✅ F6 BIOS by American Megatrends Inc. (S/N NXA82EV0EBB0760, version ALASKA - 1072009)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Write-Progress "⏳ Querying BIOS details..."
	if ($IsLinux) {
		$Model = (sudo dmidecode -s system-product-name)
		if ("$Model" -ne "") {
			$Manufacturer = (sudo dmidecode -s system-manufacturer)
			$Version = (sudo dmidecode -s bios-version)
			$RelDate = (sudo dmidecode -s bios-release-date)
			Write-Host "✅ $Model BIOS by $Manufacturer ($Version release of $RelDate)"
		}
	} else {
		$BIOS = Get-CimInstance -ClassName Win32_BIOS
		$Model = $BIOS.Name.Trim()
		$Manufacturer = $BIOS.Manufacturer.Trim()
		$Serial = $BIOS.SerialNumber.Trim()
		$Version = $BIOS.Version.Trim()
		Write-Host "✅ $Model BIOS by $Manufacturer (S/N $Serial, version $Version)"
	}
	Write-Progress -completed "BIOS query finished."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}