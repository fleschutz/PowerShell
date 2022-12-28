<#
.SYNOPSIS
	Checks BIOS details
.DESCRIPTION
	This PowerShell script queries and prints BIOS details.
.EXAMPLE
	PS> ./check-bios
	✅ F6 BIOS by American Megatrends Inc. (S/N NXA82EV0EBB0760, version ALASKA - 1072009)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Write-Progress "Querying BIOS details..."
	if ($IsLinux) {
		$Model = (sudo dmidecode -s system-product-name)
		$Manufacturer = (sudo dmidecode -s system-manufacturer)
		$Version = (sudo dmidecode -s bios-version)
		$RelDate = (sudo dmidecode -s bios-release-date)
		"✅ $Model BIOS by $Manufacturer (version $Version as of $RelDate)"
	} else {
		$BIOS = Get-CimInstance -ClassName Win32_BIOS
		$Model = $BIOS.Name.Trim()
		$Manufacturer = $BIOS.Manufacturer.Trim()
		$Serial = $BIOS.SerialNumber.Trim()
		$Version = $BIOS.Version.Trim()
		"✅ $Model BIOS by $Manufacturer (S/N $Serial, version $Version)"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
