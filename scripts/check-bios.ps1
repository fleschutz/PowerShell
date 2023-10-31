<#
.SYNOPSIS
	Checks the BIOS status
.DESCRIPTION
	This PowerShell script queries the BIOS status and prints it.
.EXAMPLE
	PS> ./check-bios.ps1
	✅ BIOS model P62 v02.67 by HP (version HPQOEM - 5, S/N CZC1080B01)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		Write-Progress "Querying BIOS details..."
		$model = (sudo dmidecode -s system-product-name)
		if ("$model" -ne "") {
			$version = (sudo dmidecode -s bios-version)
			$releaseDate = (sudo dmidecode -s bios-release-date)
			$manufacturer = (sudo dmidecode -s system-manufacturer)
			Write-Host "✅ BIOS model $model by $manufacturer (version $version of $releaseDate)"
		}
		Write-Progress -completed "."
	} else {
		$BIOS = Get-CimInstance -ClassName Win32_BIOS
		$model = $BIOS.Name.Trim()
		$version = $BIOS.Version.Trim()
		$serialNumber = $BIOS.SerialNumber.Trim()
		$manufacturer = $BIOS.Manufacturer.Trim()
		if ($serialNumber -eq "To be filled by O.E.M.") {
			Write-Host "✅ BIOS model $model by $manufacturer (version $version)"
		} else {
			Write-Host "✅ BIOS model $model by $manufacturer (version $version, S/N $serialNumber)"
		}
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
