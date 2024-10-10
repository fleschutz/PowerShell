<#
.SYNOPSIS
	Checks the BIOS status
.DESCRIPTION
	This PowerShell script queries the BIOS status and prints it.
.EXAMPLE
	PS> ./check-bios.ps1
	✅ BIOS model P62 v02.67, version HPQOEM - 5, S/N CZC1080B01 by HP
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
			Write-Host "✅ BIOS model $model, version $version of $releaseDate by $manufacturer"
		}
		Write-Progress -completed "."
	} else {
		$BIOS = Get-CimInstance -ClassName Win32_BIOS
		$model = $BIOS.Name.Trim()
		$version = $BIOS.Version.Trim()
		$serial = $BIOS.SerialNumber.Trim()
		$manufacturer = $BIOS.Manufacturer.Trim()
		if ($serial -eq "To be filled by O.E.M.") {
			Write-Host "✅ BIOS model $model, version $version by $manufacturer"
		} else {
			Write-Host "✅ BIOS model $model, version $version, S/N $serial by $manufacturer"
		}
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
